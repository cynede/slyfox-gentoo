# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit base mk-configure

DESCRIPTION="Wrapper for AWK providing modules"
HOMEPAGE="http://sourceforge.net/projects/runawk/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=("${FILESDIR}"/${P}-decl.patch)
