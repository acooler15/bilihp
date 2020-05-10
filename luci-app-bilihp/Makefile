include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bilihp
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=BiliHP for LuCI
	PKGARCH:= all
endef

define Package/$(PKG_NAME)/description
	This package contains LuCI configuration pages for BiliHP.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/root/etc/config/bilihp $(1)/etc/config/bilihp

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/root/etc/init.d/bilihp $(1)/etc/init.d/bilihp

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/*.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/bilihp
	$(INSTALL_DATA) ./luasrc/model/cbi/bilihp/*.lua $(1)/usr/lib/lua/luci/model/cbi/bilihp/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/bilihp
	$(INSTALL_DATA) ./luasrc/view/bilihp/* $(1)/usr/lib/lua/luci/view/bilihp/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	po2lmo ./po/zh-cn/bilihp.po $(1)/usr/lib/lua/luci/i18n/bilihp.zh-cn.lmo

endef

define Package/$(PKG_NAME)/preinst
	#!/bin/bash
	echo 'installing $(PKG_NAME)'
endef

define Package/$(PKG_NAME)/postinst
	#!/bin/sh
	# check if we are on real system
	if [ -z "$${IPKG_INSTROOT}" ]; then
			echo "Enabling rc.d symlink for $(PKG_NAME)"
			/etc/init.d/bilihp enable
	fi

	echo '$(PKG_NAME) installed successed !'
	exit 0
endef

define Package/$(PKG_NAME)/prerm
	#!/bin/sh
	# check if we are on real system
	if [ -z "$${IPKG_INSTROOT}" ]; then
			echo "Removing rc.d symlink for $(PKG_NAME)"
			/etc/init.d/bilihp disable
	fi
	echo 'removeing $(PKG_NAME)'
	exit 0
endef

define Package/$(PKG_NAME)/postrm
	#!/bin/bash
	echo '$(PKG_NAME) remove successed !'
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
