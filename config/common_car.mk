# Inherit common spark stuff
$(call inherit-product, vendor/spark/config/common.mk)

# Inherit spark car device tree
$(call inherit-product, device/spark/car/spark_car.mk)

# Inherit the main AOSP car makefile that turns this into an Automotive build
$(call inherit-product, packages/services/Car/car_product/build/car.mk)
