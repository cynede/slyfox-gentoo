# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: bmake.eclass
# @MAINTAINER:
# Sergei Trofimovich <slyfox@gentoo.org>
# @BLURB: for bmake based build systems

inherit multiprocessing toolchain-funcs

: ${BMAKE:=bmake}
: ${BMAKE_NOPARALLEL:=yes-it-is-broken}

: ${BMAKE_PREFIX:=${EPREFIX}/usr}
: ${BMAKE_SYSCONFDIR:=${EPREFIX}/etc}
: ${BMAKE_MANDIR:=${BMAKE_PREFIX}/share/man}

DEPEND="sys-devel/bmake"

EXPORT_FUNCTIONS src_compile src_test src_install

bmake_run_tool() {
	local phase_env_args=(
		# bmake-based build systems are very sensitive
		# to external environment variables.
		# At least 'app-misc/runawk' is affected by FILESDIR
		-u FILESDIR
	)
	local job_args="-j $(makeopts_jobs)"

	phase_env_args+=(
		PREFIX="${BMAKE_PREFIX}"
		SYSCONFDIR="${BMAKE_SYSCONFDIR}"
		MANDIR="${BMAKE_MANDIR}"

		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		LD="$(tc-getLD)"

		CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS}"
	)

	# at least bmake on mk-configure fails to parse '-j N install' commandline
	[[ -n ${BMAKE_NOPARALLEL} ]] && job_args=
	set -- env "${phase_env_args[@]}" ${BMAKE} ${job_args} "$@"
	echo "$@"
	"$@" || die
}

bmake_src_compile() {
	bmake_run_tool
}

bmake_src_test() {
	bmake_run_tool test
}

bmake_src_install() {
	bmake_run_tool DESTDIR="${D}" install
}
