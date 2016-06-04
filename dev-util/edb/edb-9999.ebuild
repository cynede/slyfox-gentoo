# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit cmake-utils git-r3

DESCRIPTION="cross platform x86/x86-64 debugger (inspired by Ollydbg)"
HOMEPAGE="https://github.com/eteran/edb-debugger/"
EGIT_REPO_URI="https://github.com/eteran/edb-debugger.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-libs/capstone-3.0.4-r1:=
	dev-qt/qtcore:5=
	dev-qt/qtconcurrent:5=
	dev-qt/qtgui:5=
	dev-qt/qtnetwork:5=
	dev-qt/qtwidgets:5=
	dev-qt/qtxml:5=
	dev-qt/qtxmlpatterns:5=
	>=media-gfx/graphviz-2.38.0:=
"
DEPEND="${RDEPEND}"

src_compile() {
	addpredict /proc
	cmake-utils_src_compile
}
