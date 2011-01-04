# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcc/tcc-0.9.25.ebuild,v 1.1 2009/07/10 21:44:58 truedfx Exp $

inherit eutils git

IUSE=""
DESCRIPTION="A very small C compiler for ix86/amd64"
HOMEPAGE="http://bellard.org/tcc/"
EGIT_REPO_URI="git://repo.or.cz/tinycc.git"
EGIT_TREE="mob"
EGIT_BRANCH="mob"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

DEPEND=""
# Both tendra and tinycc install /usr/bin/tcc
RDEPEND="!dev-lang/tendra"

# Testsuite is broken, relies on gcc to compile
# invalid C code that it no longer accepts
RESTRICT="test"

src_unpack() {
	git_src_unpack
	cd "${S}"

	# Don't strip
	sed -i -e 's|$(INSTALL) -s|$(INSTALL)|' Makefile

	# Fix examples
	sed -i -e '1{
		i#! /usr/bin/tcc -run
		/^#!/d
	}' examples/ex*.c
	sed -i -e '1s/$/ -lX11/' examples/ex4.c
}

src_compile() {
	local myopts
	use x86 && myopts="--cpu=x86"
	use amd64 && myopts="--cpu=x86-64"
	econf ${myopts} \
	    --cc="$(tc-getCC)" \
	    --extra-cflags="$CFLAGS" \
	    --extra-ldflags="$LDFLAGS"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc Changelog README TODO VERSION
	dohtml tcc-doc.html
	exeinto /usr/share/doc/${PF}/examples
	doexe examples/ex*.c
}
