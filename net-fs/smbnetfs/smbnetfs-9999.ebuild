# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils autotools git

DESCRIPTION="SMBNetFS is a Linux/FreeBSD FUSE filesystem that allow you to use samba/microsoft network."
HOMEPAGE="http://sourceforge.net/projects/smbnetfs"
EGIT_REPO_URI="git://smbnetfs.git.sourceforge.net/gitroot/smbnetfs/smbnetfs"
#SRC_URI="mirror://sourceforge/smbnetfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=sys-fs/fuse-2.3
	>=net-fs/samba-3.2[smbclient]"

DEPEND="${RDEPEND}
	sys-devel/libtool
	sys-devel/make"

src_unpack() {
	git_src_unpack ${A}
	cd "${S}"
	./autogen.sh || die "./autogen.sh failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog README INSTALL RUSSIAN.FAQ
}

pkg_postinst() {
	elog
	elog "For quick usage, exec:"
	elog "'modprobe fuse'"
	elog "'smbnetfs -oallow_other /mnt/samba'"
	elog
}
