################################################################################
#
# webinterface
#
################################################################################

WEBINTERFACE_VERSION = b62ae0d5439e8dd72bffe34817cab298c1e8bcb4
WEBINTERFACE_GIT_SUBMODULES = YES
WEBINTERFACE_SITE_METHOD = git
WEBINTERFACE_SITE = git://github.com/aroio/webinterface
WEBINTERFACE_LICENSE = MIT
WEBINTERFACE_DEPENDENCIES = python3 python-uvicorn python-fastapi python-pyjwt

define AROIO_WEBINTERFACE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		-C $(@D) all
endef

define AROIO_WEBINTERFACE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/webinterface
	cp -r $(@D)/frontend/dist/aroio-wi/* $(TARGET_DIR)/opt/webinterface
	cp $(@D)/webinterface.service $(TARGET_DIR)/lib/systemd/system/
	ln -sf $(TARGET_DIR)/lib/systemd/system/webinteraface.service $(TARGET_DIR)/lib/systemd/system/multi-user.target.wants/webinterface.service
endef

$(eval $(generic-package))
