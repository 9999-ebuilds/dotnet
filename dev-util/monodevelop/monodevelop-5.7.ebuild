# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop/monodevelop-9999.ebuild $

EAPI=5
inherit fdo-mime gnome2-utils dotnet versionator eutils git-2

DESCRIPTION="Integrated Development Environment for .NET"
HOMEPAGE="http://www.monodevelop.com/"

EGIT_REPO_URI="git://github.com/mono/monodevelop.git"
EGIT_MASTER="master"
EGIT_NONBARE="keep-files"

LICENSE="GPL-2"
SLOT="570"
KEYWORDS=""
IUSE="git subversion sql"

RDEPEND=">=dev-lang/mono-3.0.1
	>=dev-dotnet/glade-sharp-2.12.9
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gtk-sharp-2.12.9
	>=dev-dotnet/mono-addins-0.6[gtk]
	>=dev-dotnet/xsp-2
	dev-util/ctags
	sys-apps/dbus[X]
	|| (
		www-client/firefox
		www-client/firefox-bin
		www-client/seamonkey
		)
	!<dev-util/monodevelop-boo-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-java-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-database-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-debugger-gdb-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-debugger-mdb-$(get_version_component_range 1-2)
	!<dev-util/monodevelop-vala-$(get_version_component_range 1-2)"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	x11-misc/shared-mime-info"

MAKEOPTS="${MAKEOPTS} -j1" #nowarn

#src_prepare() {
#	einfo remove PreBuild section for NUnit.csproj and NUnitRunner.csproj
#}

src_configure() {
# econf \
#  --disable-update-mimedb \
#  --disable-update-desktopdb \
#  --enable-monoextensions \
#  --enable-gnomeplatform \
#     $(use_enable subversion) \
#     $(use_enable git)
  einfo EXTRA_ECONF="${EXTRA_ECONF}"

  ./configure ${EXTRA_ECONF} \
     || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
