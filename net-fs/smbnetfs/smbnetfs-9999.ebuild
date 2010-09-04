# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils autotools git

DESCRIPTION="FUSE filesystem for SMB shares"
HOMEPAGE="http://sourceforge.net/projects/smbnetfs"
EGIT_REPO_URI="git://smbnetfs.git.sourceforge.net/gitroot/smbnetfs/smbnetfs"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gnome"

RDEPEND=">=sys-fs/fuse-2.3
	>=net-fs/samba-3.2[smbclient]
	gnome? ( gnome-base/gnome-keyring )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/libtool
	sys-devel/make"

src_prepare() {
	eautoreconf
	#./autogen.sh || die "./autogen.sh failed"
}

src_configure() {
	econf $(use_with gnome gnome-keyring) || die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	elog
	elog "For quick usage, exec:"
	elog "'modprobe fuse'"
	elog "'smbnetfs -oallow_other /mnt/samba'"
	elog
}
