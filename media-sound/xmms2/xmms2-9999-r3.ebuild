# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $

inherit eutils git

DESCRIPTION="X(cross)platform Music Multiplexing System. The new generation of the XMMS player."
HOMEPAGE="http://xmms2.xmms.org"

EGIT_REPO_URI=git://git.xmms.se/xmms2/xmms2-devel
EGIT_PROJECT=xmms2-devel

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

# TODO: split plugins, options and sort em properly
IUSE="
aac
alsa
ao
asx
avcodec
cdda
curl
cxx
clientonly
daap
diskwrite
ecore
eq
flac
hack_cp1251
jack
mdns
mlib-update
mms
mp3
mp4
modplug
mpg123
musepack
nofileread
nophonehome
oss
perl
pulseaudio
python
rss
ruby
samba
sid
speex
vorbis
vocoder
xspf
xml
"

RESTRICT="nomirror"

#TODO:
# < mama> for DEPEND, python is build time dep, not runtime, unless you're building bindings
# < mama> also, you never ever put gcc in DEPEND unless you're in the toolchain herd or it's a system package
# >>>>> but i suspect we need gcc[cxx]
# < mama> _if_ you want to provide python bindings install app-portage/eclass-manpages and look at python.eclass

# perpetual TODO:
# FIXME: from 'src/plugins/*/wscript'

DEPEND="!clientonly? (
		>=dev-db/sqlite-3.3.4

		aac? ( >=media-libs/faad2-2.0 )
		alsa? ( media-libs/alsa-lib )
		ao? ( media-libs/libao )
		cdda? ( >=media-libs/libdiscid-0.1.1
			>=media-sound/cdparanoia-3.9.8 )
		curl? ( >=net-misc/curl-7.15.1 )
		flac? ( media-libs/flac )
		jack? ( >=media-sound/jack-audio-connection-kit-0.101.1 )
		mdns? ( net-dns/avahi )
		mms? ( media-video/ffmpeg
			>=media-libs/libmms-0.3 )
		modplug? ( media-libs/libmodplug )
		mp3? ( media-sound/madplay )
		mp4? ( media-video/ffmpeg )
		musepack? ( media-libs/libmpcdec )
		pulseaudio? ( media-sound/pulseaudio )
		rss? ( dev-libs/libxml2 )
		samba? ( net-fs/samba )
		sid? ( media-sound/sidplay
			media-libs/resid )
		speex? ( media-libs/speex )
		vorbis? ( media-libs/libvorbis )
		vocoder? ( sci-libs/fftw media-libs/libsamplerate )
		xml? ( dev-libs/libxml2 )
		xspf? ( dev-libs/libxml2 )
	)
	>=dev-lang/python-2.4.3
	>=dev-libs/glib-2.12.9
	cxx? ( >=dev-libs/boost-1.32
			>=sys-devel/gcc-3.4 )
	ecore? ( x11-libs/ecore )
	perl? ( >=dev-lang/perl-5.8.8 )
	python? ( >=dev-python/pyrex-0.9.5.1 )
	ruby? ( >=dev-lang/ruby-1.8.5 )
	mlib-update? ( app-admin/gamin )
	mpg123? ( >=media-sound/mpg123-1.5.1 ) "

RDEPEND="${DEPEND}"

S=${WORKDIR}/xmms2-devel

src_unpack() {
	git_src_unpack
	cd ${S}
	sed -i -e 's,/sbin/ldconfig,/bin/true,g' wscript || die "unadle to sed out 'ldconfig' from wscript"
}

src_compile() {
	local exc=""
	local excl_pls=""
	local excl_opts=""
	local options="--conf-prefix=/etc --prefix=/usr --destdir=${D}"
	if use clientonly ; then
		exc="--without-xmms2d=1 "
	else
		use nophonehome && excl_opts="${excl_opts},et"
		use ecore || excl_opts="${excl_opts},xmmsclient-ecore"
		use ruby || excl_opts="${excl_opts},ruby"
		use python || excl_opts="${excl_opts},python"
		use cxx || excl_opts="${excl_opts},xmmsclient++,xmmsclient++-glib"
		use mdns || excl_opts="${excl_opts},avahi"
		use alsa || excl_pls="${excl_pls},alsa"
		use pulseaudio || excl_pls="${excl_pls},pulse"
		use curl || excl_pls="${excl_pls},curl"
		use aac || excl_pls="${excl_pls},faad"
		use flac || excl_pls="${excl_pls},flac"
		use vorbis || excl_pls="${excl_pls},ices"
		use jack || excl_pls="${excl_pls},jack"
		use mp3 || excl_pls="${excl_pls},mad"
		use modplug || excl_pls="${excl_pls},modplug"
		use musepack || excl_pls="${excl_pls},musepack"
		use oss || excl_pls="${excl_pls},oss"
		use samba || excl_pls="${excl_pls},samba"
		use sid || excl_pls="${excl_pls},sid"
		use speex || excl_pls="${excl_pls},speex"
		use vorbis || excl_pls="${excl_pls},vorbis"
		use vocoder || excl_pls="${excl_pls},vocoder"
		use mms || excl_pls="${excl_pls},mms"
		use eq || excl_pls="${excl_pls},equalizer"
		use xspf || excl_pls="${excl_pls},xspf"
		use ao || excl_pls="${excl_pls},ao"
		use mp4 || excl_pls="${excl_pls},mp4"
		use diskwrite || excl_pls="${excl_pls},diskwrite"
		use cdda || excl_pls="${excl_pls},cdda"
		use nofileread && excl_pls="${excl_pls},file"
		use xml || excl_pls="${excl_pls},xml"
		use daap || excl_pls="${excl_pls},daap"
		use avcodec || excl_pls="${excl_pls},avcodec"
		use asx || excl_pls="${excl_pls},asx"
		use rss || excl_pls="${excl_pls},rss"
		use mlib-update || excl_opts="${excl_opts},medialib-updater"
		use mpg123 || excl_pls="${excl_pls},mpg123"
	fi

	

	if [ ${excl_pls} != "" ]
	then
		options="${options} --without-plugins=${excl_pls:1}"
	fi
	if [ ${excl_opts} != "" ]
	then
		options="${options} --without-optionals=${excl_opts:1}"
	fi

	${S}/waf ${options} configure || die "Configure failed"
	${S}/waf build || die "Build failed"
}

src_install() {
	${S}/waf --destdir=${D} install || die
	dodoc AUTHORS COPYING TODO README
}

pkg_postinst() {
	einfo "This version is built on experimental development code"
	einfo "If you encounter any errors report them at http://bugs.xmms2.xmms.se"
	einfo "and visit #xmms2 at irc://irc.freenode.net"
	einfo "xmms2 is a user server, not a system wide daemon"
	if use ! nophonehome ; then
		einfo ""
		einfo "The phone-home client xmms2-et was activated"
		einfo "This client sends anonymous usage-statistics to the xmms2"
		einfo "developers which may help finding bugs"
		einfo "Disable the phonehome useflag if you don't like that"
	fi
}
