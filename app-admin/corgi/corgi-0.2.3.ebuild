# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-base golang-vcs-snapshot

EGO_PN="${PN}"
DESCRIPTION="Corgi is a command-line workflow manager that helps with your repetitive command usages by organizing them into reusable snippet"
HOMEPAGE="https://github.com/DrakeW/corgi"
SRC_URI="https://github.com/DrakeW/corgi/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="test"

#S=${WORKDIR}/${P}/src/${EGO_PN}

src_prepare() {
    default
    export GOPATH=${S}
    cd ${S}/src/${EGO_PN} || die
    ebegin "Ensuring deps"
    dep ensure -update

}

src_compile() {
    cd ${S}/src/${EGO_PN} || die
    go build -o ${PN}
}

src_install() {
    cd ${S}/src/${EGO_PN} || die
    dobin corgi
}
