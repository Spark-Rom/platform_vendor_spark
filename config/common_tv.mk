# Inherit common Lineage stuff
$(call inherit-product, vendor/spark/config/common.mk)

# Inherit Lineage atv device tree
$(call inherit-product, device/spark/atv/spark_atv.mk)

# AOSP packages
PRODUCT_PACKAGES += \
    LeanbackIME

# Lineage packages
PRODUCT_PACKAGES += \
    LineageCustomizer

PRODUCT_PACKAGE_OVERLAYS += vendor/spark/overlay/tv
