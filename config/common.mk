# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)
$(call inherit-product, vendor/spark/config/bootanimation.mk)
$(call inherit-product, vendor/addons/config.mk)
$(call inherit-product, external/faceunlock/config.mk)
$(call inherit-product-if-exists, vendor/spark/audio/audio.mk)

PRODUCT_BRAND ?= Spark

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

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
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/spark/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/spark/prebuilt/common/bin/50-lineage.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-lineage.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-lineage.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/spark/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/spark/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Spark-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/spark/config/permissions/spark-sysconfig.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/spark-sysconfig.xml

# Spark-specific init rc file
PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/etc/init/init.spark-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.spark-system_ext.rc

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/spark/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Spark!
PRODUCT_COPY_FILES += \
    vendor/spark/config/permissions/org.lineageos.android.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.lineageos.android.xml

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/spark/config/lineage_sdk_common.mk
endif

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

ifneq ($(TARGET_DISABLE_EPPE),true)
# Require all requested packages to exist
$(call enforce-product-packages-exist-internal,$(wildcard device/*/$(LINEAGE_BUILD)/$(TARGET_PRODUCT).mk),product_manifest.xml rild Calendar Launcher3 Launcher3Go Launcher3QuickStep Launcher3QuickStepGo android.hidl.memory@1.0-impl.vendor vndk_apex_snapshot_package)
endif

# Lineage packages
PRODUCT_PACKAGES += \
    LineageParts \
    LineageSettingsProvider

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Extra tools in Spark
PRODUCT_PACKAGES += \
    bash \
    curl \
    getcap \
    htop \
    nano \
    setcap \
    vim

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/curl \
    system/bin/getcap \
    system/bin/setcap

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

PRODUCT_COPY_FILES += \
    vendor/spark/prebuilt/common/etc/init/init.openssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.openssh.rc

ifneq ($(WITH_GAPPS), true)
# Enable gestural navigation overlay to match default navigation mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural
endif

ifeq ($(WITH_GAPPS), true)
# GApps
$(call inherit-product, vendor/gms/products/gms.mk)
include vendor/gms/products/board.mk
endif

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# Root
PRODUCT_PACKAGES += \
    adb_root

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Launcher3QuickStep \
    Settings \
    SystemUI

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/spark/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/spark/overlay/common \
    vendor/spark/overlay/no-rro

PRODUCT_PACKAGES += \
    DocumentsUIOverlay \
    NetworkStackOverlay

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/spark/build/target/product/security/spark

PRODUCT_PACKAGES += \
    SettingsIntelligenceGooglePrebuilt

# AdBlock
PRODUCT_PACKAGES += \
    hosts.spark_adblock

# Extra packages
PRODUCT_PACKAGES += \
    GameSpace \
    OmniJaws \
    ParallelSpace

# Additional props
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.google.ime.theme_id=5 \
    drm.service.enabled=true \
    media.mediadrmservice.enable=true \
    persist.sys.disable_rescue=true \
    ro.opa.eligible_device=true

# Setupwizard
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.esim_cid_ignore=00000001 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.day_night_mode_enabled=true \
    setupwizard.feature.lifecycle_refactoring=true \
    setupwizard.feature.notification_refactoring=true \
    setupwizard.feature.portal_notification=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=true \
    setupwizard.feature.show_support_link_in_deferred_setup=false \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.theme=glif_v3_light

include vendor/spark/config/version.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
