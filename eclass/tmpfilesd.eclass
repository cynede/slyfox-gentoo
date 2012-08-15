# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# @ECLASS: tmpfilesd.eclass
# @MAINTAINER:
# slyfox@gentoo.org
# @AUTHOR:
# Based on bash-completion-r1.eclass by Michał Górny <mgorny@gentoo.org>.
# @BLURB: Helpers to install tmpfiles.d files.
# @DESCRIPTION:
# As described in http://0pointer.de/public/systemd-man/tmpfiles.d.html
# helpers allow installing package's tmpfiles.d into /usr/lib/tmpfiles.d
# @EXAMPLE:
#
# @CODE
# EAPI=4
#
# src_install() {
# 	default
#
# 	newtmpfilesd ${FILESDIR}/tmpfilesd.conf ${PN}.conf
# }
# @CODE

case ${EAPI:-0} in
	0|1|2|3|4) ;;
	*) die "EAPI ${EAPI} is unknown."
esac

# @FUNCTION: dotmpfilesd
# @USAGE: file [...]
# @DESCRIPTION:
# Install tmpfiles.d files passed as args. Has EAPI-dependant failure
# behavior (like doins).
dotmpfilesd() {
	debug-print-function ${FUNCNAME} "${@}"

	(
		insinto /usr/lib/tmpfiles.d
		doins "${@}"
	)
}

# @FUNCTION: newtmpfilesd
# @USAGE: file newname
# @DESCRIPTION:
# Install tmpfiles.d file under a new name. Has EAPI-dependant failure
# behavior (like newins).
newtmpfilesd() {
	debug-print-function ${FUNCNAME} "${@}"

	(
		insinto /usr/lib/tmpfiles.d
		newins "${@}"
	)
}
