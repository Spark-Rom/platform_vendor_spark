# Inherit common mobile Lineage stuff
$(call inherit-product, vendor/spark/config/common.mk)

# Include AOSP audio files
include vendor/spark/config/aosp_audio.mk

# Include Lineage audio files
include vendor/spark/config/spark_audio.mk

# Default notification/alarm sounds
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

# Apps
PRODUCT_PACKAGES += \
    Aperture \
    Backgrounds \
    Eleven \
    Etar \
    ExactCalculator \
    Jelly \
    Profiles \
    Seedvault

ifneq ($(TARGET_EXCLUDES_AUDIOFX),true)
PRODUCT_PACKAGES += \
    AudioFX
endif

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub
