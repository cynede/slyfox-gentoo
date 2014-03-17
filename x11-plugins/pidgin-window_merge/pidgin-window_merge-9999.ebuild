# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-led-notification/pidgin-led-notification-0.1.ebuild,v 1.7 2013/02/08 17:11:08 xmw Exp $

EAPI=5

inherit autotools-utils git-r3

DESCRIPTION="pidgin plugin that merges a conversation window with the Buddy List window"
HOMEPAGE="https://github.com/dm0-/window_merge"
MY_PN=${PN/pidgin-/}
MY_P=${MY_PN}-${PV}
EGIT_REPO_URI="git://github.com/dm0-/window_merge.git"

LICENSE="GPL-2"
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
