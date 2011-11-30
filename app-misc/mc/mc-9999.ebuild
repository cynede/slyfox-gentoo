# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mc/mc-4.7.5.2.ebuild,v 1.1 2011/04/12 13:54:22 wired Exp $

EAPI=4

inherit autotools flag-o-matic git-2

DESCRIPTION="GNU Midnight Commander is a text based file manager"
HOMEPAGE="http://midnight-commander.org"
EGIT_REPO_URI="git://midnight-commander.org/git/mc.git"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS=""

IUSE="+edit gpm mclib +ncurses nls samba slang test X"

REQUIRED_USE="^^ ( ncurses slang )"

RDEPEND=">=dev-libs/glib-2.8:2
	gpm? ( sys-libs/gpm )
	kernel_linux? ( sys-fs/e2fsprogs )
	ncurses? ( sys-libs/ncurses )
	samba? ( net-fs/samba )
	slang? ( >=sys-libs/slang-2 )
	X? ( x11-libs/libX11
		x11-libs/libICE
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libSM )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	test? ( dev-libs/check )
	"

# needed only for SCM source tree (autopoint uses it)
DEPEND="${DEPEND} dev-vcs/cvs"

src_prepare() {
	./autogen.sh
}

src_configure() {
	local myscreen=ncurses
	use slang && myscreen=slang
	[[ ${CHOST} == *-solaris* ]] && append-ldflags "-lnsl -lsocket"

	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--enable-vfs \
		$(use_enable kernel_linux vfs-undelfs) \
		--enable-charset \
		$(use_with X x) \
		$(use_enable samba vfs-smb) \
		$(use_with gpm gpm-mouse) \
		--with-screen=${myscreen} \
		$(use_with edit) \
		$(use_enable mclib) \
		$(use_enable test tests)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README NEWS

	# fix bug #334383
	if use kernel_linux && [[ ${EUID} == 0 ]] ; then
		fowners root:tty /usr/libexec/mc/cons.saver ||
			die "setting cons.saver's owner failed"
		fperms g+s /usr/libexec/mc/cons.saver ||
			die "setting cons.saver's permissions failed"
	fi
}

pkg_postinst() {
	elog "To enable exiting to latest working directory,"
	elog "put this into your ~/.bashrc:"
	elog ". ${EPREFIX}/usr/libexec/mc/mc.sh"
}
