# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bmake

DESCRIPTION="bmake-based Lightweight replacement for autotools"
HOMEPAGE="http://sourceforge.net/projects/mk-configure/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT=test # assumes DESTDIR=/ and PREFIX=/usr/local

RDEPEND="sys-devel/bmake
	x11-misc/makedepend
"
DEPEND="${RDEPEND}"

src_install() {
	bmake_run_tool DESTDIR="${D}" install
}
