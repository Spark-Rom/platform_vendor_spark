# Set spark specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit full common spark stuff
$(call inherit-product, vendor/spark/config/common_full_phone.mk)
