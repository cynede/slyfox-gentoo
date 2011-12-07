# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bdelta/bdelta-0.1.0.ebuild,v 1.6 2009/07/11 17:35:56 vostorga Exp $

EAPI="2"

inherit multilib toolchain-funcs eutils subversion

DESCRIPTION="Binary Delta - Efficient difference algorithm and format"
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI=""
ESVN_REPO_URI="svn://deltup.org/bdelta/trunk"
ESVN_PROJECT="bdelta"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

src_prepare() {
	# Fixing ldflags
	epatch "${FILESDIR}"/${PN}-9999-ldflags.patch
	# Set correct libdir
	sed -i -e "s:\(LIBDIR=\${PREFIX}/\)lib:\1$(get_libdir):" \
		"${S}"/src/Makefile || die "sed failed"
}

src_compile() {
	emake -C src CC="$(tc-getCC)" CXXFLAGS="${CXXFLAGS}" -j1 || die "emake failed"
}

src_install() {
	dodir /usr/$(get_libdir)
	make -C src DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
