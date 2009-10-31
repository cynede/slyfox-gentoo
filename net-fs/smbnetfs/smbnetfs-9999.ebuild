# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit eutils autotools git

DESCRIPTION="SMBNetFS is a Linux/FreeBSD filesystem that allow you to use samba/microsoft network in the same manner as the network neighborhood in Microsoft Windows."
HOMEPAGE="http://sourceforge.net/projects/smbnetfs"
EGIT_REPO_URI="git://smbnetfs.git.sourceforge.net/gitroot/smbnetfs/smbnetfs"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=sys-fs/fuse-2.3
	>=net-fs/samba-libs-3.2[smbclient]"

DEPEND="${RDEPEND}
	virtual/libc
	sys-devel/libtool
	sys-devel/make"

src_unpack() {
	git_src_unpack "${A}"
	cd "${S}"
	./autogen.sh || die "./autogen.sh failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc COPYING AUTHORS ChangeLog README  smbnetfs.conf INSTALL RUSSIAN.FAQ
}

pkg_postinst() {
	einfo ""
	einfo "For quick usage, exec:"
	einfo "'modprobe fuse'"
	einfo "'smbnetfs -oallow_other /mnt/samba'"
	einfo ""
}
