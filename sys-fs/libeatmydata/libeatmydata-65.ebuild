# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit eutils

DESCRIPTION="LD_PRELOAD hack to convert sync()/msync() and the like to NO-OP"
HOMEPAGE="https://launchpad.net/libeatmydata/"
SRC_URI="https://launchpad.net/${PN}/trunk/release-${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# sandbox fools LD_PRELOAD and libeatmydata does not get control
# bug/feature in sandbox?
RESTRICT=test
#DEPEND="test? ( dev-util/strace )"

DEPEND="sys-apps/sed"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install

	prune_libtool_files --all
	dodoc AUTHORS README
}
