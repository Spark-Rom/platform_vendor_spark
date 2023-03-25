# Inherit mini common Lineage stuff
$(call inherit-product, vendor/spark/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    androidx.window.extensions \
    LatinIME

$(call inherit-product, vendor/spark/config/telephony.mk)
