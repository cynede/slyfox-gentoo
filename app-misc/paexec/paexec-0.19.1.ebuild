# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multiprocessing

DESCRIPTION="Parallel executor"
HOMEPAGE="http://sourceforge.net/projects/paexec/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-devel/bmake
	dev-util/mk-configure
	app-misc/runawk"

src_prepare() {
	export PREFIX=${EPREFIX}/usr
	export SYSCONFDIR=${EPREFIX}/etc
	export DESTDIR="${D}"
	export MANDIR=${PREFIX}/share/man
}

src_compile() {
	mkcmake all || die
}

src_install() {
	mkcmake install || die
}
