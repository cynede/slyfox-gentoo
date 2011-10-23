# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

FIRMWARE_NAME="htc_9271.fw"

DESCRIPTION="Atheros firmware for AR9271 (ath9k_htc module)"
HOMEPAGE="http://linuxwireless.org/en/users/Drivers/ath9k_htc"
SRC_URI="http://linuxwireless.org/download/htc_fw/${PV}/${FIRMWARE_NAME} -> ${P}-${FIRMWARE_NAME}
	http://linuxwireless.org/download/htc_fw/${PV}/Changelog -> ${P}.Changelog"

LICENSE="as-is" # fixme
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror binchecks strip"
SLOT="0"
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() { :; }

src_prepare() {
	cp "${DISTDIR}"/${P}-${FIRMWARE_NAME} "${WORKDIR}"/${FIRMWARE_NAME} || die
	cp "${DISTDIR}"/${P}.Changelog "${WORKDIR}"/Changelog || die
}

src_compile() { :; }

src_install() {
	insinto /lib/firmware
	doins "${FIRMWARE_NAME}" || die

	dodoc Changelog
}
