pkgname="waydroid-script-git"
gives="waydroid-script"
pkgver"177.1a2d3ad"
source=("https://github.com/casualsnek/waydroid_script.git")
makedepends=("git")
pacdeps=("waydroid-deb")
depends=("python3-requests" "python3-tqdm" "python3-inquirer" "python3-dbus" "lzip" "libsqlite3-dev")
breaks=("${gives}")
pkgdesc=("Python Script to add OpenGapps, Magisk, libhoudini translation library and libndk translation library to Waydroid")
maintainer=("James Ed Randson <jimedrand@disroot.org>")
external_connection=true
incompatible=("debian:bullseye" "debian:bookworm" "ubuntu:jammy" "ubuntu:focal")

package() {
    cd ${srcdir}/$_repo_name
    install -d ${pkgdir}/opt/${_pkgname}
    cp -r * ${pkgdir}/opt/${_pkgname}/
    chmod +x ${pkgdir}/opt/${_pkgname}/main.py
    install -d ${pkgdir}/usr/bin
    ln -s /opt/${_pkgname}/main.py ${pkgdir}/usr/bin/waydroid-extras
    install -Dm755 ${pkgdir}/opt/${_pkgname}/LICENSE ${pkgdir}/usr/share/licenses/$pkgname/LICENSE
    install -Dm755 ${pkgdir}/opt/${_pkgname}/README.md ${pkgdir}/usr/share/doc/$pkgname/README.md
    rm -rf ${pkgdir}/opt/${_pkgname}/{LICENSE,README.md,requirements.txt,assets}
}




