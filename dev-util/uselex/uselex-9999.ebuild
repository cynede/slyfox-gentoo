# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs git-2

DESCRIPTION="look for USEless EXports in object files"
HOMEPAGE="https://github.com/trofi/uselex/"
EGIT_REPO_URI="git://github.com/trofi/uselex.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-lang/ruby"
DEPEND=""

src_install() {
	dobin ${PN}.rb
}
