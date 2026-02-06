################################################################################
#
# ldd
#
################################################################################

BR2_ROOTFS_OVERLAY="../base_external/rootfs_overlay/"

#LDD_VERSION = '8315bce6c2f51d53e8e5ba4fce5de1a95de672b2'
LDD_VERSION = 66ddae1385c20af0053046710f3f3534fa772b50
#LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-sturgetto.git'
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-sturgetto.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

LDD_MODULE_SUBDIRS = misc-modules scull
LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

define LDD_CONFIGURE_CMDS
	echo "Configure LDD!"
endef

define LDD_BUILD_CMDS
        $(MAKE) -C $(@D)/scull 
        $(MAKE) -C $(@D)/misc-modules
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define LDD_INSTALL_TARGET_CMDS
        $(INSTALL) -d -m 0755 $(TARGET_DIR)/lib/modules/6.1.44/kernel/drivers/char/
        $(INSTALL) -m 0755 $(@D)/scull/scull.ko $(TARGET_DIR)/lib/modules/6.1.44/kernel/drivers/char/
        $(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/lib/modules/6.1.44/kernel/drivers/char/
        $(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/lib/modules/6.1.44/kernel/drivers/char/
        $(INSTALL) -d -m 0755 $(TARGET_DIR)/lib/modules/6.1.44/kernel/drivers/misc/
        $(INSTALL) -m 0755 $(@D)/misc-modules/*.ko $(TARGET_DIR)/lib/modules/6.1.44/kernel/drivers/misc/
        $(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/lib/modules/6.1.44/kernel/drivers/misc/
        $(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/lib/modules/6.1.44/kernel/drivers/misc/
endef

$(eval $(kernel-module))
$(eval $(autotools-package))

