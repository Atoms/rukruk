# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit git-r3 cmake-utils


EGIT_REPO_URI="https://github.com/f1xpl/${PN}.git"


DESCRIPTION="Library to build AndroidAuto headunit"
HOMEPAGE="https://github.com/f1xpl/${PN}"

SRC_URI=""

LICENSE="GPL3"
KEYWORDS=""
IUSE=""
SLOT="0"

DEPEND="
    dev-libs/libusb
    dev-libs/protobuf
    dev-libs/openssl
    dev-libs/boost
    dev-util/cmake
    dev-vcs/git
    "

src_configure() {
    cmake-utils_src_configure
}
src_compile() {
    cmake-utils_src_compile
}

src_install() {
    dolib lib/libaasdk.so
    dolib lib/libaasdk_proto.so
    cd ${WORKDIR}
    dodir /usr/include/aasdk_proto
    insinto /usr/include/aasdk_proto
    for file in `ls aasdk-${PV}_build/aasdk_proto/*.h`; do
        doins ${file}
    done
    dodir /usr/include/
    insinto /usr/include/
    doins -r aasdk-${PV}/include/f1x/
}

pkg_postinst() {
	elog "Please report bugs at: https://github.com/Atoms/rukruk"
}