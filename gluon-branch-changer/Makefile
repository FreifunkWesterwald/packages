include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-branch-changer
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/gluon-branch-changer
  SECTION:=westerwald
  CATEGORY:=Customization
  TITLE:=Branch changer
  DEPENDS:=+gluon-core
  MAINTAINER:=Freifunk Westerwald
  URL:=https://github.com/FreifunkWesterwald/packages
  SOURCE:=https://github.com/FreifunkWesterwald/packages.git
endef

define Package/gluon-branch-changer/description
	Branch changer
endef

define Build/Prepare
        mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-branch-changer/install
        $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,gluon-branch-changer))
