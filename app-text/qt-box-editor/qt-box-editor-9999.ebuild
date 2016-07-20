# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit qmake-utils git-r3

DESCRIPTION="Editor of tesseract-ocr box files"
HOMEPAGE="http://zdenop.github.com/qt-box-editor/"
#SRC_URI="https://github.com/zdenop/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/zdenop/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-text/tesseract:=
	dev-qt/qtwidgets:5=
	dev-qt/qtcore:5=
	dev-qt/qtgui:5=
	dev-qt/qtnetwork:5=
	media-libs/leptonica:=
"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	default # does not do anything, needs a .pro fix
	dobin qt-box-editor-*
}
