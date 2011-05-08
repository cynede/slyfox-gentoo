# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit findlib

DESCRIPTION="an LR(1) parser generator for the Objective Caml"
HOMEPAGE="http://cristal.inria.fr/~fpottier/menhir/"
SRC_URI="http://cristal.inria.fr/~fpottier/menhir/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.10"
RDEPEND="${DEPEND}"

src_compile() {
	emake -j1 PREFIX="$EROOT"/usr || die
}

src_install() {
	findlib_src_preinst
	emake PREFIX="$D"/usr install || die
}
