include vendor/spark/config/ProductConfigQcom.mk

PRODUCT_SOONG_NAMESPACES += $(PATHMAP_SOONG_NAMESPACES)

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/spark/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/spark/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

# backuptool
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/spark/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/spark/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh

# system mount
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/bin/system-mount.sh:install/bin/system-mount.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/spark/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/spark/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1 \
    persist.sys.disable_rescue=true \
    ro.opa.eligible_device=true \
    ro.setupwizard.rotation_locked=true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Spark Common
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/etc/permissions/privapp-permissions-spark.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-spark.xml \
    vendor/spark/prebuilt/common/etc/permissions/privapp-permissions-spark-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-spark-product.xml \
    vendor/spark/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-elgoog.xml \
    vendor/spark/config/permissions/pixel_experience_2020.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2020.xml

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/spark/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Clang
ifeq ($(TARGET_USE_LATEST_CLANG),true)
    TARGET_KERNEL_CLANG_VERSION := $(shell grep -v based prebuilts/clang/host/$(HOST_OS)-x86/*/AndroidVersion.txt | sort | tail -n 1 | cut -d : -f 2)
endif

# Disable Rescue Party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
    SELINUX_IGNORE_NEVERALLOWS := true
endif

ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

# Overlays
PRODUCT_PACKAGES += \
    CustomConfigOverlay \
    CustomLauncherOverlay \
    CustomSettingsOverlay

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Bootanimation
PRODUCT_COPY_FILES += \
vendor/spark/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip

# Packages
include vendor/spark/config/packages.mk

# Inherit from audio config
$(call inherit-product, vendor/spark/config/audio.mk)

# Branding
include vendor/spark/config/branding.mk

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/spark/overlay

DEVICE_PACKAGE_OVERLAYS += vendor/spark/overlay/common

include packages/overlays/Themes/themes.mk

# GVM
PRODUCT_PACKAGES += \
    GVM-SBH-L \
    GVM-SBH-M \
    GVM-SBH-XL \
    GVM-URM-M \
    GVM-URM-L \
    GVM-URM-R \
    GVM-PGM-BLUE \
    GVM-PGM-ORCD \
    GVM-PGM-OPRD \
    GVM-PGM-PURP \
    GVM-PGM-ROSE

# Switch themes
PRODUCT_PACKAGES += \
    SwitchAOSP \
    SwitchContained \
    SwitchTelegram \
    SwitchRetro \
    SwitchMD2 \
    SwitchOOS

# QS Header size
PRODUCT_PACKAGES += \
    HeaderLarge \
    HeaderXLarge

# Custom Overlays
# Settings
PRODUCT_PACKAGES += \
    SystemRavenBlackOverlay \
    SystemUIRavenBlackOverlay \
    SystemDarkGrayOverlay \
    SystemUIDarkGrayOverlay \
    SystemStyleOverlay \
    SystemUIStyleOverlay \
    SystemNightOverlay \
    SystemUINightOverlay \
    SystemUISolarizedDarkOverlay \
    SystemMaterialOceanOverlay \
    SystemUIMaterialOceanOverlay \
    SystemBakedGreenOverlay \
    SystemUIBakedGreenOverlay \
    SystemChocoXOverlay \
    SystemUIChocoXOverlay \
    SystemDarkAubergineOverlay \
    SystemUIDarkAubergineOverlay \
    SystemClearSpringOverlay \
    SystemUIClearSpringOverlay

# QS tile styles
PRODUCT_PACKAGES += \
    QStileCircleTrim \
    QStileDefault \
    QStileDualToneCircle \
    QStileSquircleTrim \
    QStileAttemptMountain \
    QStileDottedCircle \
    QStileNinja \
    QStilePokesign \
    QStileWavey \
    QStileCookie \
    QStileInkDrop \
    QStileSquaremedo \
    QStileCosmos \
    QStileDividedCircle \
    QStileNeonLight \
    QStileOxygen \
    QStileTriangles \
    QStileCircleOutline

# Navbar
PRODUCT_PACKAGES += \
    GesturalNavigationOverlayHidden \
    GesturalNavigationOverlayLong \
    GesturalNavigationOverlayMedium \
    GesturalNavigationRadiusLow \
    GesturalNavigationRadiusVeryLow \
    GesturalNavigationRadiusHidden

ifeq ($(WITH_FOD_ANIMATIONS),true)
PRODUCT_PACKAGES += \
    FodAnimationResources
endif

# Plugins
include packages/apps/Plugins/plugins.mk

