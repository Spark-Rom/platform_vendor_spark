# Inherit common Lineage stuff
$(call inherit-product, vendor/spark/config/common_mobile.mk)

PRODUCT_SIZE := full

# Apps
PRODUCT_PACKAGES += \
    Aperture \
    Etar \
    Profiles \
    Recorder

# Extra cmdline tools
PRODUCT_PACKAGES += \
    unrar \
    zstd
