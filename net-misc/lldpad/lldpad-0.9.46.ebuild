# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools

DESCRIPTION="Link Layer Discovery Protocol Implementation"
HOMEPAGE="http://www.open-lldp.org/"
SRC_URI="http://ftp-osl.osuosl.org/pub/open-lldp/open-lldp-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kernel_linux"

COMMON_DEPEND="dev-libs/libconfig
	dev-libs/libnl:1.1
"
DEPEND="${COMMON_DEPEND}
	sys-devel/flex
	virtual/pkgconfig
	kernel_linux? ( >=sys-kernel/linux-headers-2.6.29 )
"
RDEPEND="${COMMON_DEPEND}
	sys-apps/iproute2
"

S="${WORKDIR}/open-lldp-${PV}"

src_unpack() {
    unpack ${A}
    cd ${S}
}

src_prepare() {
        default_src_prepare
	sed -i -e '/AM_CFLAGS/ s/-Werror //' Makefile.am || die
	sed -i -e 's/^AM_INIT_AUTOMAKE(\[/AM_INIT_AUTOMAKE(\[subdir-objects /' configure.ac || die
	elibtoolize
	eautoreconf
}

src_configure() {
	econf
}
src_compile(){
	emake
}
src_install() {
	emake DESTDIR="${D}" install
	rm -r "${D}"etc/init.d || die
	newinitd "${FILESDIR}"/lldpad.init lldpad
}
