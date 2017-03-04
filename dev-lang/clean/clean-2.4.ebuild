# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib versionator

MY_P=${PN}${PV}
MY_DIR=Clean$(delete_version_separator 1)

DESCRIPTION="general purpose, state-of-the-art, pure and lazy functional programming language"
HOMEPAGE="http://wiki.clean.cs.ru.nl/"
SRC_URI="
	amd64? ( http://clean.cs.ru.nl/download/${MY_DIR}/linux/${MY_P}_64.tar.gz )
	x86? ( http://clean.cs.ru.nl/download/${MY_DIR}/linux/${MY_P}.tar.gz )
"

LICENSE="LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""
RDEPEND=""

PATCHES=("${FILESDIR}"/${P}-jobserver.patch)

RESTRICT="strip splitdebug"

QA_PREBUILT="*"

S=${WORKDIR}/${PN}

src_compile() {
	: # default 'make' breaks paths
}

src_install() {
	# fails at parallel building
	emake -j1 install \
		INSTALL_DIR="${ED}/usr" \
		INSTALL_MAN_DIR="${ED}/usr/share/man" \
		INSTALL_LIB_DIR="${ED}/usr/$(get_libdir)"

	# yeah, it sucks, but build system hates staging installations
	einfo "patching clm's CLEANPATH and CLEANILIB"
	bin/patch_bin "${ED}"/usr/bin/clm CLEANPATH "${EROOT}"/usr/$(get_libdir)/StdEnv || die
	bin/patch_bin "${ED}"/usr/bin/clm CLEANLIB  "${EROOT}"/usr/$(get_libdir)/exe || die

	local f
	for f in "${ED}"/usr/bin/* "${ED}/usr/$(get_libdir)"/exe/*; do
		fperms 755 "${f#$D}"
	done
}
