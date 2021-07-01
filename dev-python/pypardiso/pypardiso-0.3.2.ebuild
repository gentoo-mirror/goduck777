# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..10} )

inherit distutils-r1

DESCRIPTION="Python interface to the Intel MKL Pardiso library"
HOMEPAGE="https://github.com/haasad/PyPardisoProject"
SRC_URI="https://github.com/haasad/PyPardisoProject/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/PyPardisoProject-${PV}"

RDEPEND="dev-python/mkl-service[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
"
