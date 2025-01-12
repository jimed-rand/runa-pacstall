pkgname=waydroid
gives=waydroid
pkgver="1.4.3"
pkgrel="2"
pkgdesc="Bring Android support on your own Wayland session which runs under LXC container"
arch=("any")
url="https://waydro.id/"
maintainer=("James Ed Randson <jimedrand@disroot.org>")
depends=("lxc" "dnsmasq" "python3" "python3-gi" "gir1.2-gtk-3.0" "dbus" "python3-dbus" "polkitd" "iptables" "python3-pyclipper")
makedepends=("pkg-config" "libglib2.0-dev")
source=(
        "https://github.com/sailfishos/libglibutil/archive/refs/tags/1.0.79.tar.gz"
        "https://github.com/mer-hybris/libgbinder/archive/refs/tags/1.1.42.tar.gz"
        "https://github.com/erfanoabdi/gbinder-python/archive/refs/heads/master.zip"
        "https://github.com/waydroid/waydroid/archive/refs/heads/main.zip"
)
sha256sums=(
        "4d689cb79f8ea061e46b89008370dc771b07164ee496850d9d56d9d85f1be1c3"
        "32dcf31c5dc823af11558d180ed5fabb160fdfafe60f01d3212fd200a0842aed"
        "SKIP"
        "SKIP"
)

build(){
    cd ${srcdir}/libglibutil-1.0.79
    make KEEP_SYMBOLS=1 release pkgconfig
    cd ${srcdir}/libgbinder-1.1.42
    make KEEP_SYMBOLS=1 release pkgconfig
    cd ${srcdir}/gbinder-python-master
    python3 setup.py build --cython
}

package(){
    cd ${srcdir}/libglibutil-1.0.79
    make install-dev DESTDIR="${pkgdir}/usr/share/waydroid/libglibutil"
    cd ${srcdir}/libgbinder-1.1.42
    make install-dev DESTDIR="${pkgdir}/usr/share/waydroid/libgbinder"
    cd ${srcdir}/gbinder-python-master
    python3 setup.py install --prefix=/usr --root="${pkgdir}/usr/share/waydroid/python-gbinder"
    cd ${srcdir}/waydroid-main
    make -C waydroid install DESTDIR="${pkgdir}/usr/share/waydroid" USE_NFTABLES=1
    cat << EOF > "${pkgdir}/usr/share/applications/waydroid.desktop"
[Desktop Entry]
Name=Waydroid
Comment=Bring Android support on your own Wayland session.
Exec=/usr/share/waydroid/waydroid
Icon=/usr/share/waydroid/icon.png
Terminal=false
Type=Application
Categories=Utility;
EOF
}
