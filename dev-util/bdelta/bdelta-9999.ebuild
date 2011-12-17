# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bdelta/bdelta-0.1.0.ebuild,v 1.6 2009/07/11 17:35:56 vostorga Exp $

EAPI="4"

inherit git-2 multilib toolchain-funcs

DESCRIPTION="Binary Delta - Efficient difference algorithm and format"
HOMEPAGE="http://bdelta.org"
SRC_URI=""
EGIT_REPO_URI="git://github.com/jjwhitney/BDelta.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

src_compile() {
	emake -C src \
		CXX="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	emake -C src install \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	dodoc README
}
