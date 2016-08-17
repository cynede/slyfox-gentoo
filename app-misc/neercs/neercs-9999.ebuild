# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit autotools git-r3

DESCRIPTION="Terminal multiplexer with unique features"
HOMEPAGE="http://caca.zoy.org/wiki/neercs"
EGIT_REPO_URI="git://git.zoy.org/neercs.git"

LICENSE="WTFPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	media-libs/libcaca:0=
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	./bootstrap || die
}
