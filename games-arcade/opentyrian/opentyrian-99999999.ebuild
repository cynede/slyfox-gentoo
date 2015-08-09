# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils games mercurial

DESCRIPTION="Open-source port of the DOS game Tyrian, vertical scrolling shooter"
HOMEPAGE="http://code.google.com/p/opentyrian/"
SRC_URI="http://darklomax.org/tyrian/tyrian21.zip"
EHG_REPO_URI=http://opentyrian.googlecode.com/hg/

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/hg

src_unpack() {
	mercurial_src_unpack ${A}
	base_src_unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/20091025-datapath.diff"
	epatch "${FILESDIR}/99999999-cflag-idiocy.diff"
}

src_compile() {
	emake DATA_PATH="${GAMES_DATADIR}/${PN}" || die "Compilation failed"
}

src_install() {
	dogamesbin opentyrian || die "Failed to install game binary"
	dodoc CREDITS NEWS README || die "Failed to install documentation"
	domenu linux/opentyrian.desktop || die "Failed to install desktop file"
#	doicon tyrian.xpm || die "Failed to install program icon"
	insinto "${GAMES_DATADIR}/${PN}"
	cd "${WORKDIR}/tyrian21" || die "Failed to cd to game data"
	doins * || die "Failed to install game data"
	prepgamesdirs
}
