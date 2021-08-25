# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	ansi_term-0.12.1
	anyhow-1.0.42
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.2.1
	byte-unit-4.0.12
	cassowary-0.3.0
	cfg-if-1.0.0
	chrono-0.4.19
	clap-3.0.0-beta.2
	clap_derive-3.0.0-beta.2
	colored-2.0.0
	const-sha1-0.2.0
	core-foundation-sys-0.8.2
	crossbeam-0.8.1
	crossbeam-channel-0.5.1
	crossbeam-deque-0.8.0
	crossbeam-epoch-0.9.5
	crossbeam-queue-0.3.2
	crossbeam-utils-0.8.5
	crossterm-0.19.0
	crossterm_winapi-0.7.0
	crosstermion-0.7.0
	ctor-0.1.20
	diff-0.1.12
	doc-comment-0.3.3
	either-1.6.1
	filesize-0.2.0
	fixedbitset-0.4.0
	form_urlencoded-1.0.1
	glob-0.3.0
	hashbrown-0.11.2
	heck-0.3.3
	hermit-abi-0.1.19
	idna-0.2.3
	indexmap-1.7.0
	instant-0.1.10
	itertools-0.10.1
	jwalk-0.6.0
	lazy_static-1.4.0
	libc-0.2.98
	lock_api-0.4.4
	log-0.4.14
	malloc_buf-0.0.6
	matches-0.1.8
	memoffset-0.6.4
	mio-0.7.13
	miow-0.3.7
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	numtoa-0.1.0
	objc-0.2.7
	once_cell-1.8.0
	open-2.0.0
	os_str_bytes-2.4.0
	output_vt100-0.1.2
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	pathdiff-0.2.0
	percent-encoding-2.1.0
	petgraph-0.6.0
	pretty_assertions-0.7.2
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.27
	quote-1.0.9
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.2.9
	redox_termios-0.1.2
	scopeguard-1.1.0
	signal-hook-0.1.17
	signal-hook-registry-1.4.0
	smallvec-1.6.1
	strsim-0.10.0
	syn-1.0.73
	sysinfo-0.19.1
	termcolor-1.1.2
	termion-1.5.6
	textwrap-0.12.1
	time-0.1.44
	tinyvec-1.2.0
	tinyvec_macros-0.1.0
	trash-2.0.1
	tui-0.15.0
	tui-react-0.15.0
	unicode-bidi-0.3.5
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	url-2.2.2
	utf8-width-0.1.5
	vec_map-0.8.2
	version_check-0.9.3
	wasi-0.10.0+wasi-snapshot-preview1
	wild-2.0.4
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.8.0
	windows_gen-0.8.0
	windows_macros-0.8.0
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
