# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-4 )

inherit desktop lua-single qmake-utils xdg

DESCRIPTION="Multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/freeciv/freeciv"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="aimodules auth dedicated +gtk ipv6 mapimg modpack mysql nls qt5 readline sdl +server +sound sqlite system-lua"

REQUIRED_USE="system-lua? ( ${LUA_REQUIRED_USE} )"

RDEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	net-misc/curl
	sys-libs/zlib
	auth? (
		!mysql? ( ( !sqlite? ( dev-db/mysql-connector-c:0= ) ) )
		mysql? ( dev-db/mysql-connector-c:0= )
		sqlite? ( dev-db/sqlite:3 )
	)
	dedicated? ( aimodules? ( dev-libs/libltdl:0 ) )
	!dedicated? (
		media-libs/libpng:0
		gtk? ( x11-libs/gtk+:3 )
		mapimg? ( media-gfx/imagemagick:= )
		modpack? ( x11-libs/gtk+:3 )
		nls? ( virtual/libintl )
		qt5? (
			dev-qt/qtcore:5
			dev-qt/qtgui:5
			dev-qt/qtwidgets:5
		)
		!sdl? ( !gtk? ( x11-libs/gtk+:3 ) )
		sdl? (
			media-libs/libsdl2[video]
			media-libs/sdl2-gfx
			media-libs/sdl2-image[png]
			media-libs/sdl2-ttf
		)
		server? ( aimodules? ( sys-devel/libtool:2 ) )
		sound? (
			media-libs/libsdl2[sound]
			media-libs/sdl2-mixer[vorbis]
		)
	)
	readline? ( sys-libs/readline:0= )
	system-lua? ( ${LUA_DEPS} )
"
DEPEND="${RDEPEND}
	!dedicated? ( x11-base/xorg-proto )
"
# postgres isn't yet really supported by upstream
BDEPEND="
	virtual/pkgconfig
	!dedicated? ( nls? ( sys-devel/gettext ) )
"

#S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! use dedicated && ! use server ; then
		ewarn "Disabling server USE flag will make it impossible to start local"
		ewarn "games, but you will still be able to join multiplayer games."
	fi

	use system-lua && lua-single_pkg_setup
}

src_prepare() {
	default

	if [[ "${PV}" == "9999" ]]; then
		sed -i \
			-e 's/FC_RUN_CONFIGURE=yes/FC_RUN_CONFIGURE=no/' \
			./autogen.sh || die
		./autogen.sh || die
	fi
}

src_configure() {
	local myclient=() mydatabase=() mymodpack=() myeconfargs=()

	if use auth ; then
		if ! use mysql && ! use sqlite ; then
			einfo "No database backend chosen, defaulting"
			einfo "to mysql!"
			mydatabase=( mysql )
		else
			use mysql && mydatabase+=( mysql )
			use sqlite && mydatabase+=( sqlite3 )
		fi
	else
		mydatabase=( no )
	fi

	if use dedicated ; then
		myclient=( no )
		myeconfargs+=(
			--enable-server
			--enable-freeciv-manual
		)
	else
		if use !sdl && use !gtk && ! use qt5 ; then
			einfo "No client backend given, defaulting to gtk3 client!"
			myclient=( gtk3.22 )
		else
			use sdl && myclient+=( sdl2 )
			use gtk && myclient+=( gtk3.22 )
			if use qt5 ; then
				local -x MOCCMD=$(qt5_get_bindir)/moc
				myclient+=( qt )
			fi
		fi
		myeconfargs+=(
			$(use_enable server)
			$(use_enable server freeciv-manual)
		)
	fi
	if use !modpack ; then
		mymodpack=( no )
	else
		if use !gtk && ! use qt5 ; then
			mymodpack=( gtk3 )
		else
			use gtk && mymodpack+=( gtk3 )
			use qt5 && mymodpack+=( qt )
		fi
	fi
	myeconfargs+=(
		--enable-aimodules="$(usex aimodules "yes" "no")"
		--enable-client="${myclient[*]}"
		--enable-fcdb="${mydatabase[*]}"
		--enable-fcmp="${mymodpack[*]}"
		# disabling shared libs will break aimodules USE flag
		--enable-shared
		--localedir=/usr/share/locale
		--with-appdatadir="${EPREFIX}"/usr/share/metainfo
		$(use_enable ipv6)
		$(use_enable mapimg)
		$(use_enable nls)
		$(use_enable sound sdl-mixer)
		$(use_enable system-lua sys-lua)
		$(use_with readline)
		$(use_with qt5)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	if use dedicated ; then
		rm -rf "${ED}"/usr/share/pixmaps || die
		rm -f "${ED}"/usr/share/man/man6/freeciv-{client,gtk2,gtk3,modpack,qt,sdl,xaw}* || die
	else
		if use server ; then
			# Create and install the html manual. It can't be done for dedicated
			# servers, because the 'freeciv-manual' tool is then not built. Also
			# delete freeciv-manual from the GAMES_BINDIR, because it's useless.
			# Note: to have it localized, it should be ran from _postinst, or
			# something like that, but then it's a PITA to avoid orphan files...
			./tools/freeciv-manual || die
			docinto html
			dodoc civ2civ3*.html
		fi
		if use sdl ; then
			make_desktop_entry freeciv-sdl "Freeciv (SDL)" freeciv-client
		else
			rm -f "${ED}"/usr/share/man/man6/freeciv-sdl* || die
		fi
		rm -f "${ED}"/usr/share/man/man6/freeciv-xaw* || die
	fi
	find "${ED}" -name "freeciv-manual*" -delete || die

	rm -f "${ED}/usr/$(get_libdir)"/*.a || die
	find "${ED}" -type f -name "*.la" -delete || die
}
