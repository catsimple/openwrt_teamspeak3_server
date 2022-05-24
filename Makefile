#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ts3server
PKG_VERSION:=3.13.6
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Instant Messaging
	TITLE:=Teamspeak3 Server.
	DEPENDS:=@(i386||x86_64) +libc
	URL:=https://www.teamspeak.com/
endef

define Package/$(PKG_NAME)/description
Teamspeak3 Server.
endef

define Package/$(PKG_NAME)/extra_provides
	echo 'libc.so.6'; \
	echo 'libdl.so.2'; \
	echo 'librt.so.1'; \
	echo 'libm.so.6'; \
	echo 'libpq.so.5'; \
	echo 'libpthread.so.0'; \
	echo 'libstdc++.so.6';
endef

ifeq ($(ARCH),x86_64)
	BIN_ARCH:=amd64

endif
ifeq ($(ARCH),i386)
	BIN_ARCH:=x86
endif

STRIP:=true
PKG_SOURCE:=teamspeak3-server_linux_$(BIN_ARCH)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://files.teamspeak-services.com/releases/server/$(PKG_VERSION)
PKG_HASH:=skip
UNZIP_DIR:=$(PKG_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/$(PKG_NAME)-unzip

define Build/Prepare
	mkdir -vp $(UNZIP_DIR)
	tar -jxvf $(DL_DIR)/$(PKG_SOURCE) -C $(UNZIP_DIR)
endef

define Build/Configure
endef

define Build/Compile
	$(CP) ./files $(PKG_BUILD_DIR)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin/ts3server
	$(CP) $(UNZIP_DIR)/teamspeak3-server_linux_$(BIN_ARCH)/* $(1)/usr/bin/ts3server
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/ts3server.init $(1)/etc/init.d/ts3server
	$(CP) $(PKG_BUILD_DIR)/files/ts3server_startscript.sh $(1)/usr/bin/ts3server/ts3server_startscript.sh
	
	chmod 755 -R $(1)/usr/bin/ts3server
	chmod 775 $(1)/etc/init.d/ts3server

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
