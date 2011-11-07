# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Tool to set nodatacow flag"
HOMEPAGE="http://dave.jikos.cz/"
SRC_URI="http://dave.jikos.cz/nocow.c -> ${P}-nocow.c"

LICENSE="public domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() { :; }

src_prepare() {
	cp "${DISTDIR}"/${P}-nocow.c "${WORKDIR}"/ || die
}

src_compile() {
	$(tc-getCC) -o ${PN} ${CFLAGS} ${LDFLAGS} ${P}-nocow.c || die "Cannot compile ${PN}"
}

src_install() {
	dobin ${PN}
}
