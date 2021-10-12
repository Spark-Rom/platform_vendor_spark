# Set spark specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit mini common spark stuff
$(call inherit-product, vendor/spark/config/common_mini_phone.mk)
