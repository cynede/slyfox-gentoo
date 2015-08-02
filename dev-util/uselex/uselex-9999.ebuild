# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

inherit ruby-single git-2

DESCRIPTION="look for USEless EXports in object files"
HOMEPAGE="https://github.com/trofi/uselex/"
EGIT_REPO_URI="git://github.com/trofi/uselex.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${RUBY_DEPS}"

src_install() {
	dobin ${PN}.rb
}
