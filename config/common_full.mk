# Inherit common Lineage stuff
$(call inherit-product, vendor/spark/config/common_mobile.mk)

PRODUCT_SIZE := full

# Extra cmdline tools
PRODUCT_PACKAGES += \
    zstd

# Recorder
PRODUCT_PACKAGES += \
    Recorder
