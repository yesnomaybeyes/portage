# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )
DISTUTILS_SINGLE_IMPL="1"

inherit distutils-r1

EGIT_REPO_URI="https://github.com/varietywalls/variety"
inherit git-r3

DESCRIPTION="Wallpaper changer for Linux"
HOMEPAGE="http://peterlevi.com/variety"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="help"

DEPEND="dev-python/python-distutils-extra[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=x11-libs/libnotify-0.7[introspection]
	dev-python/configobj[${PYTHON_USEDEP}]
	media-libs/gexiv2[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=x11-libs/pango-1[introspection]
	>=dev-libs/glib-2
	dev-python/pycurl[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	>=x11-libs/gdk-pixbuf-2[introspection]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	help? ( gnome-extra/yelp )
	media-gfx/imagemagick
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pygobject[cairo,${PYTHON_USEDEP}]"
