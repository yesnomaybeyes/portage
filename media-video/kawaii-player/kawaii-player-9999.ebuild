# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 git-r3



DESCRIPTION="Kawaii-player"
HOMEPAGE="https://github.com/kanishka-linux/kawaii-player"

EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"


RDEPEND="${PYTHON_DEPS} dev-python/pycurl
dev-python/pillow
media-libs/mutagen
dev-python/certifi
dev-python/dbus-python
dev-python/PyQt5
dev-qt/qtwebengine
dev-python/lxml
dev-python/beautifulsoup:4"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

python_compile() {
distutils-r1_python_compile
}

python_install_all() {
distutils-r1_python_install_all
}
