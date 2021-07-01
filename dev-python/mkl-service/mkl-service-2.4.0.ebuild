# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..10} )

inherit distutils-r1

DESCRIPTION="Python hooks for Intel(R) Math Kernel Library runtime control settings"
HOMEPAGE="https://github.com/IntelPython/mkl-service"
SRC_URI="https://github.com/IntelPython/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sci-libs/mkl
	dev-python/cython[${PYTHON_USEDEP}]
"

src_prepare() {
	default

	sed -e '/MKL_ENABLE_AVX2_E1/d' -i mkl/* || die
}

python_compile() {
	local -x MKLROOT=${EPREFIX}/usr
	local -x C_INCLUDE_PATH=${EPREFIX}/usr/include/mkl

	distutils-r1_python_compile
}

python_install() {
	local -x MKLROOT=${EPREFIX}/usr

	distutils-r1_python_install
}
