# Recipe created by recipetool
# Updated with assistance from DeepSeek: https://chat.deepseek.com/share/bc8l0zt9bbune09m32
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
#
# The following license files were not able to be identified and are
# represented as "Unknown" below, you will need to check them yourself:
#   LICENSE
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://git@github.com/cu-ecen-aeld/assignment-7-jordankooyman.git;protocol=ssh;branch=main \
           file://0001-Update-LDD-Build-to-only-do-misc-modules-and-scull.patch \
           "

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "9577cd1e389f13013f548e018b1c7d2fa11fd071"


inherit module

SRC_URI += "file://scull-init.sh"

inherit update-rc.d
INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME:${PN} = "scull-init.sh"

MODULES_INSTALL_TARGET = "install"
EXTRA_OEMAKE:append = " -C ${STAGING_KERNEL_DIR} M=${S}/scull"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/scull-init.sh ${D}${sysconfdir}/init.d/scull
}
