# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils flag-o-matic subversion

DESCRIPTION="find unused include directives in C/C++ programs"
HOMEPAGE="https://code.google.com/p/include-what-you-use/"
ESVN_REPO_URI="http://include-what-you-use.googlecode.com/svn/trunk/"
ESVN_PROJECT="include-what-you-use"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND=">=sys-devel/llvm-3.4"
DEPEND="${RDEPEND}"

src_configure() {
	append-ldflags -L$(llvm-config --libdir)

	local mycmakeargs=(
		-DLLVM_PATH=$(llvm-config --libdir)
	)
	cmake-utils_src_configure
}
