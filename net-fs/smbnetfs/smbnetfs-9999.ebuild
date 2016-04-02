# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools git-2 readme.gentoo

DESCRIPTION="FUSE filesystem for SMB shares"
HOMEPAGE="http://sourceforge.net/projects/smbnetfs"
EGIT_REPO_URI="git://git.code.sf.net/p/smbnetfs/git"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gnome"

RDEPEND=">=sys-fs/fuse-2.3
	>=net-fs/samba-3.2[smbclient(+)]
	gnome? ( gnome-base/gnome-keyring )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/libtool
	sys-devel/make"

DISABLE_AUTOFORMATTING=yes
DOC_CONTENTS="
For quick usage, exec:
'modprobe fuse'
'smbnetfs -oallow_other /mnt/samba'
"

src_prepare() {
	eautoreconf
	#./autogen.sh || die "./autogen.sh failed"
}

src_configure() {
	econf $(use_with gnome gnome-keyring)
}

src_install() {
	default
	readme.gentoo_create_doc
	dodoc AUTHORS ChangeLog
}
