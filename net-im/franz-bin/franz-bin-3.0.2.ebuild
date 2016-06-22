# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils autotools

DESCRIPTION="Franz is a free messaging app / former Emperor of Austria and combines chat & messaging services into one application. He currently supports Slack, WhatsApp, WeChat, HipChat, Facebook Messenger, Telegram, Google Hangouts, GroupMe, Skype and many more."
HOMEPAGE="http://meetfranz.com/"

SRC_URI="https://github.com/imprecision/franz-app/releases/download/${PV}/Franz-linux-x64-${PV}.tgz"

SLOT='0'

KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

S="${WORKDIR}"

src_unpack() {
    unpack ${A}
}

src_install() {
    dodir /usr/share/Franz/
    cp -R ${WORKDIR}/* ${D}/usr/share/Franz || die "Install failed!"
    dolib ${WORKDIR}/libnode.so
    dolib ${WORKDIR}/libffmpeg.so
    domenu ${FILESDIR}/franz.desktop
    doicon ${WORKDIR}/resources/app.asar.unpacked/assets/franz.png
    dodir /usr/bin
    dosym /usr/share/Franz/Franz /usr/bin/Franz
}
