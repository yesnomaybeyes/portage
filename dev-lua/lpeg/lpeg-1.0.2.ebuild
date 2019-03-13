# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Parsing Expression Grammars for Lua"
HOMEPAGE="http://www.inf.puc-rio.br/~roberto/lpeg/"
SRC_URI="http://www.inf.puc-rio.br/~roberto/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~mips ~ppc ~ppc64 ~x86"
IUSE="debug doc luajit"

RDEPEND="
	!luajit? ( >=dev-lang/lua-5.1:= )
	luajit? ( dev-lang/luajit:2= )"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig"

DOCS=( HISTORY )
HTML_DOCS=( lpeg.html re.html )
PATCHES=(
"${FILESDIR}"/${PN}-1.0.2-makefile.patch
"${FILESDIR}"/${PN}-1.0.2-makefile-2.patch
)

src_prepare() {
	default
	use debug && append-cflags -DLPEG_DEBUG
}

src_compile() {
#	emake CC="$(tc-getCC)" \
	LUADIR="$($(tc-getPKG_CONFIG) --variable includedir $(usex luajit 'luajit' 'lua'))"
	gcc -fPIC -O2  -I$LUADIR -c lpcap.c -o lpcap.o
	gcc -fPIC -O2  -I$LUADIR -c lpcode.c -o lpcode.o
	gcc -fPIC -O2  -I$LUADIR -c lpprint.c -o lpprint.o
	gcc -fPIC -O2  -I$LUADIR -c lptree.c -o lptree.o
	gcc -fPIC -O2  -I$LUADIR -c lpvm.c -o lpvm.o


	ar cr liblpeg.a lpcap.o lpcode.o lpprint.o lptree.o lpvm.o
	ranlib lpeg.a
# For building lpeg.so, which we don't need now that we're statically linking lpeg.a into falco
gcc -shared -o liblpeg.so -L/usr/lib lpcap.o lpcode.o lpprint.o lptree.o lpvm.o
#gcc -shared -o lpeg.so -L/usr/local/lib lpcap.o lpcode.o lpprint.o lptree.o lpvm.o



}

src_test() {
	$(usex luajit 'luajit' 'lua') test.lua || die
}

src_install() {
	exeinto /usr/lib64/
	doexe liblpeg.a
	doexe liblpeg.so
	exeinto /usr/lib64/lua/5.1/
	doexe liblpeg.a
	local instdir
	instdir="$($(tc-getPKG_CONFIG) --variable INSTALL_CMOD $(usex luajit 'luajit' 'lua'))"
	exeinto "${instdir#${EPREFIX}}"
	doexe liblpeg.so
	instdir="$($(tc-getPKG_CONFIG) --variable INSTALL_LMOD $(usex luajit 'luajit' 'lua'))"
	insinto "${instdir#${EPREFIX}}"/
	doins re.lua
	insinto /usr/lib64/pkgconfig
	doins ${FILESDIR}/lpeg.pc

	use doc && einstalldocs
}
