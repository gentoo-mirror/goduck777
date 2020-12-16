# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
LUA_COMPAT=(lua{5-3,5-4})

inherit cmake-utils eutils flag-o-matic xdg-utils

if [[ "${PV}" == "9999" ]]; then
    inherit git-r3

    EGIT_REPO_URI="https://github.com/nonstop/termit"
fi

DESCRIPTION="termit is a terminal emulator based on VTE library with Lua scripting"
HOMEPAGE="https://github.com/nonstop/termit"
if [[ "${PV}" == "9999" ]]; then
    SRC_URI=""
else
	SRC_URI="https://github.com/nonstop/termit/archive/termit-${PV}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	>=x11-libs/gtk+-3.22:3[X]
	>=x11-libs/vte-0.46:2.91
	${LUA_DEPS}
"
DEPEND="${RDEPEND}"

PATCHES=(
    "${FILESDIR}"/${PN}-3.1-gentoo.patch
)

src_prepare() {
	sed -e "s/\/share\/doc\/\${TERMIT_PACKAGE}/\/share\/doc\/${P}/" -i doc/CMakeLists.txt || die

	cmake-utils_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
