# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	anstream-0.3.1
	anstyle-1.0.0
	anstyle-parse-0.2.0
	anstyle-query-1.0.0
	anstyle-wincon-1.0.1
	anyhow-1.0.70
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	byte-unit-4.0.19
	cassowary-0.3.0
	cc-1.0.79
	cfg-if-1.0.0
	clap-4.2.4
	clap_builder-4.2.4
	clap_derive-4.2.0
	clap_lex-0.4.1
	colorchoice-1.0.0
	crossbeam-0.8.2
	crossbeam-channel-0.5.8
	crossbeam-deque-0.8.3
	crossbeam-epoch-0.9.14
	crossbeam-queue-0.3.8
	crossbeam-utils-0.8.15
	crossterm-0.25.0
	crossterm_winapi-0.9.0
	crosstermion-0.10.1
	ctor-0.1.26
	diff-0.1.13
	either-1.8.1
	errno-0.3.1
	errno-dragonfly-0.1.2
	filesize-0.2.0
	fixedbitset-0.4.2
	form_urlencoded-1.1.0
	glob-0.3.1
	hashbrown-0.12.3
	heck-0.4.1
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hermit-abi-0.3.1
	idna-0.3.0
	indexmap-1.9.3
	io-lifetimes-1.0.10
	is-terminal-0.4.7
	itertools-0.10.5
	jwalk-0.8.1
	libc-0.2.142
	linux-raw-sys-0.3.4
	lock_api-0.4.9
	log-0.4.17
	malloc_buf-0.0.6
	memoffset-0.8.0
	mio-0.8.6
	num_cpus-1.15.0
	numtoa-0.1.0
	objc-0.2.7
	once_cell-1.17.1
	open-3.2.0
	output_vt100-0.1.3
	owo-colors-3.5.0
	parking_lot-0.12.1
	parking_lot_core-0.9.7
	pathdiff-0.2.1
	percent-encoding-2.2.0
	petgraph-0.6.3
	pretty_assertions-1.3.0
	proc-macro2-1.0.56
	quote-1.0.26
	rayon-1.7.0
	rayon-core-1.11.0
	redox_syscall-0.2.16
	redox_termios-0.1.2
	rustix-0.37.14
	scopeguard-1.1.0
	serde-1.0.160
	signal-hook-0.3.15
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.1
	smallvec-1.10.0
	strsim-0.10.0
	syn-1.0.109
	syn-2.0.15
	termion-1.5.6
	tinyvec-1.6.0
	tinyvec_macros-0.1.1
	trash-3.0.1
	tui-0.19.0
	tui-react-0.19.0
	unicode-bidi-0.3.13
	unicode-ident-1.0.8
	unicode-normalization-0.1.22
	unicode-segmentation-1.10.1
	unicode-width-0.1.10
	url-2.3.1
	utf8-width-0.1.6
	utf8parse-0.2.1
	wasi-0.11.0+wasi-snapshot-preview1
	wild-2.1.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.44.0
	windows-sys-0.42.0
	windows-sys-0.45.0
	windows-sys-0.48.0
	windows-targets-0.42.2
	windows-targets-0.48.0
	windows_aarch64_gnullvm-0.42.2
	windows_aarch64_gnullvm-0.48.0
	windows_aarch64_msvc-0.42.2
	windows_aarch64_msvc-0.48.0
	windows_i686_gnu-0.42.2
	windows_i686_gnu-0.48.0
	windows_i686_msvc-0.42.2
	windows_i686_msvc-0.48.0
	windows_x86_64_gnu-0.42.2
	windows_x86_64_gnu-0.48.0
	windows_x86_64_gnullvm-0.42.2
	windows_x86_64_gnullvm-0.48.0
	windows_x86_64_msvc-0.42.2
	windows_x86_64_msvc-0.48.0
	yansi-0.5.1
"

inherit cargo

DESCRIPTION="View disk space usage and delete unwanted data, fast"
HOMEPAGE="https://github.com/Byron/dua-cli"
SRC_URI="https://github.com/Byron/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

DEPEND=""

RDEPEND=""

BDEPEND="${RDEPEND}"
