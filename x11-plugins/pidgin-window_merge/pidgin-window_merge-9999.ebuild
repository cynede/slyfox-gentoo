# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools-utils git-r3

DESCRIPTION="pidgin plugin that merges a conversation window with the Buddy List window"
HOMEPAGE="https://github.com/dm0-/window_merge"
MY_PN=${PN/pidgin-/}
MY_P=${MY_PN}-${PV}
EGIT_REPO_URI="git://github.com/dm0-/window_merge.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/pidgin[gtk]
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

AUTOTOOLS_PRUNE_LIBTOOL_FILES="all"

src_prepare() {
	eautoreconf
}
