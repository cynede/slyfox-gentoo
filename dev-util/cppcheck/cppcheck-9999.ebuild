# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppcheck/cppcheck-1.38.ebuild,v 1.1 2009/12/01 09:42:51 mr_bones_ Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1 eutils qt4-r2 toolchain-funcs flag-o-matic git-r3

DESCRIPTION="static analyzer of C/C++ code"
HOMEPAGE="http://cppcheck.sourceforge.net"
#SRC_URI="mirror://sourceforge/cppcheck/${P}.tar.bz2"
EGIT_REPO_URI="git://github.com/danmar/cppcheck.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="htmlreport qt4"

DEPEND="htmlreport? ( ${PYTHON_DEPS} )
	qt4? ( dev-qt/qtgui:4 )"
RDEPEND="${DEPEND}"

src_configure() {
	append-cxxflags -std=c++0x
	tc-export CXX
	if use qt4 ; then
		pushd gui
		qt4-r2_src_configure
		popd
	fi
}

src_compile() {
	emake CFLAGS="${CFLAGS}" \
		CFGDIR="/usr/share/${PN}/cfg"
	if use qt4 ; then
		pushd gui
		qt4-r2_src_compile
		popd
	fi
	if use htmlreport ; then
		pushd htmlreport
		distutils-r1_src_compile
		popd
	fi
}

src_test() {
	emake check
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc readme.txt
	insinto "/usr/share/${PN}/cfg"
	doins cfg/*.cfg
	if use qt4 ; then
		dobin gui/${PN}-gui
		dodoc readme_gui.txt gui/{projectfile.txt,gui.cppcheck}
	fi
	if use htmlreport ; then
		pushd htmlreport
		distutils-r1_src_install
		popd
		find "${D}" -name "*.egg-info" -delete
	fi
}
