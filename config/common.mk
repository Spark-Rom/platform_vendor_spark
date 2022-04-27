# Allow vendor/extras to override any property by setting it first
$(call inherit-product, vendor/spark/config/audio.mk)
$(call inherit-product-if-exists, vendor/extras/product.mk)
$(call inherit-product, vendor/spark/config/bootanimation.mk)
PRODUCT_BRAND ?= Spark

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Priv-app permissions
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/etc/permissions/privapp-permissions-spark.xml:system/etc/permissions/privapp-permissions-spark.xml \
    vendor/spark/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-elgoog.xml \
    vendor/spark/prebuilt/common/etc/permissions/googlesysconfig.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/elgoog.xml \
    vendor/spark/prebuilt/common/etc/permissions/privapp-permissions-settings.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-settings.xml \
    vendor/spark/prebuilt/common/etc/permissions/privapp-permissions-livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-livedisplay.xml

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.usb.config=adb
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.usb.config=none

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/spark/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/spark/prebuilt/common/bin/50-lineage.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-lineage.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/spark/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/spark/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/spark/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Copy all spark-specific init rc files
$(foreach f,$(wildcard vendor/spark/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/spark/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

ifneq ($(WITH_GAPPS), true)
# Enable gestural navigation overlay to match default navigation mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural
endif

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Fonts
include vendor/spark/config/fonts.mk

# Gboard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms

# Gboard side padding
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_l=4 \
    ro.com.google.ime.kb_pad_port_r=4 \
    ro.com.google.ime.kb_pad_land_l=64 \
    ro.com.google.ime.kb_pad_land_r=64

# Include AOSP audio files
#include vendor/spark/config/aosp_audio.mk

# Include spark audio files
#include vendor/spark/config/spark_audio.mk

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Screen Resolution
TARGET_SCREEN_WIDTH ?= 1080
TARGET_SCREEN_HEIGHT ?= 1920

# Charger
ifneq ($(USE_PIXEL_CHARGER),false)
PRODUCT_PACKAGES += \
    product_charger_res_images
endif

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Root
PRODUCT_PACKAGES += \
    adb_root

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Settings

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/spark/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/spark/overlay/common

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/spark/config/partner_gms.mk

# Versioning
include vendor/spark/config/version.mk

# Packages
include vendor/spark/config/packages.mk

TARGET_BUILD_LAWNCHAIR ?= false
ifeq ($(strip $(TARGET_BUILD_LAWNCHAIR)),true)
include vendor/lawnchair/lawnchair.mk
endif

ifeq ($(WITH_GAPPS), true)
# GApps
$(call inherit-product, vendor/gms/products/gms.mk)
include vendor/gms/products/board.mk
endif


# RRO Overlays
PRODUCT_PACKAGES += \
    NavigationBarModeGesturalOverlayFS \
    StrokeSignalOverlay \
    SneakySignalOverlay \
    XperiaSignalOverlay \
    ZigZagSignalOverlay \
    WavySignalOverlay \
    RoundSignalOverlay \
    InsideSignalOverlay \
    BarsSignalOverlay \
    StrokeWiFiOverlay \
    SneakyWiFiOverlay \
    XperiaWiFiOverlay \
    ZigZagWiFiOverlay \
    WavyWiFiOverlay \
    RoundWiFiOverlay \
    InsideWiFiOverlay \
    BarsWiFiOverlay

# Navbar styles
PRODUCT_PACKAGES += \
    NavbarAndroidOverlay \
    NavbarAsusOverlay \
    NavbarMotoOverlay \
    NavbarNexusOverlay \
    NavbarOldOverlay \
    NavbarOnePlusOverlay \
    NavbarOneUiOverlay \
    NavbarSammyOverlay \
    NavbarTecnoCamonOverlay

TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Udfps
ifeq ($(EXTRA_UDFPS_ANIMATIONS),true)
PRODUCT_PACKAGES += \
    UdfpsResources
endif

# GamingMode
PRODUCT_PACKAGES += \
    GamingMode

# SoftAPManager
PRODUCT_PACKAGES += \
    SoftAPManager

# Settings Intelligence
PRODUCT_PACKAGES += \
    SettingsIntelligenceGooglePrebuilt

PRODUCT_PACKAGES += \
    hosts.spark_adblock

# Themes
PRODUCT_PACKAGES += \
    AndroidBlackThemeOverlay

# Quick Tap
ifeq ($(TARGET_SUPPORTS_QUICK_TAP),true)
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/etc/sysconfig/quick_tap.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/quick_tap.xml
endif

PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/etc/sysconfig/game_overlay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/game_overlay.xml \
    vendor/spark/prebuilt/common/etc/sysconfig/GoogleCamera_6gb_or_more_ram.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/GoogleCamera_6gb_or_more_ram.xml

# Adaptive Charging
ifeq ($(TARGET_SUPPORTS_ADAPTIVE_CHARGING),true)
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/etc/sysconfig/adaptivecharging.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/adaptivecharging.xml
endif

# DreamLiner
ifeq ($(TARGET_SUPPORTS_ADAPTIVE_CHARGING),true)
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/etc/sysconfig/dreamliner.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/dreamliner.xml
endif
