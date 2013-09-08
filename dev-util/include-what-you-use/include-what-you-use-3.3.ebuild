# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils flag-o-matic

DESCRIPTION="find unused include directives in C/C++ programs"
HOMEPAGE="https://code.google.com/p/include-what-you-use/"
# picked from google drive
SRC_URI="http://dev.gentoo.org/~slyfox/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="=sys-devel/llvm-3.3*"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_configure() {
	append-ldflags -L$(llvm-config --libdir)

	local mycmakeargs=(
		-DLLVM_PATH=$(llvm-config --libdir)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	einfo "It's a bit fun to use"
	einfo "Please, look at https://code.google.com/p/include-what-you-use/wiki/InstructionsForUsers"
}
