include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bilihp
PKG_VERSION:=1.0
PKG_RELEASE:=4

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
	$(INSTALL_CONF) ./root/etc/config/bilihp $(1)/etc/config/bilihp

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/bilihp $(1)/etc/init.d/bilihp

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/*.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/bilihp
	$(INSTALL_DATA) ./luasrc/model/cbi/bilihp/*.lua $(1)/usr/lib/lua/luci/model/cbi/bilihp/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/bilihp
	$(INSTALL_DATA) ./luasrc/view/bilihp/* $(1)/usr/lib/lua/luci/view/bilihp/

	$(INSTALL_DIR) $(1)/usr/share/bilihp
	$(INSTALL_DATA) ./root/usr/share/bilihp/* $(1)/usr/share/bilihp/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	po2lmo ./po/zh-cn/bilihp.po $(1)/usr/lib/lua/luci/i18n/bilihp.zh-cn.lmo

endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
	chmod +x /usr/share/bilihp/*.sh
endef

define Package/$(PKG_NAME)/prerm
endef

define Package/$(PKG_NAME)/postrm
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
