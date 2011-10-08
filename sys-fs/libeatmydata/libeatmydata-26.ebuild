# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit eutils autotools

UBUNTU_PATCH=2
DESCRIPTION="LD_PRELOAD hack to convert sync()/msync() and the like to NO-OP"
HOMEPAGE="http://fisheye2.atlassian.com/browse/antlr/runtime/C/dist/"
SRC_URI="https://launchpad.net/ubuntu/natty/+source/${PN}/${PV}-${UBUNTU_PATCH}/+files/${PN}_${PV}.orig.tar.bz2
	https://launchpad.net/ubuntu/natty/+source/${PN}/${PV}-${UBUNTU_PATCH}/+files/${PN}_${PV}-${UBUNTU_PATCH}.debian.tar.gz"

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

src_prepare() {
	eautoreconf
	sed -i "s:/usr/lib/libeatmydata:/usr/$(get_libdir):g" \
		"$WORKDIR"/debian/lib/eatmydata.sh
}

src_install() {
	emake DESTDIR="${D}" install

	exeinto /usr/bin
	doexe "$WORKDIR"/debian/bin/eatmydata
	insinto /usr/share/${PN}/
	doins "$WORKDIR"/debian/lib/eatmydata.sh

	dodoc README
}
