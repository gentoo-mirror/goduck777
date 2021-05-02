# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

COMMIT="1cbdbcf1283499bbb2230a6b0f126eb9b236defd"
DESCRIPTION="A noise suppression library based on a recurrent neural network"
HOMEPAGE="https://gitlab.xiph.org/xiph/rnnoise"
SRC_URI="https://gitlab.xiph.org/xiph/rnnoise/-/archive/${COMMIT}/rnnoise-${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	default

	./autogen.sh || die
}

