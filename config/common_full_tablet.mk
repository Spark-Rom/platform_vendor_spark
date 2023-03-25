# Inherit full common Lineage stuff
$(call inherit-product, vendor/spark/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/spark/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/spark/overlay/dictionaries

$(call inherit-product, vendor/spark/config/telephony.mk)
