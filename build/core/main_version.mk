# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# spark Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.spark.display.version=$(SPARK_DISPLAY_VERSION) \
    ro.spark.build.version=$(SPARK_BUILD_VERSION) \
    ro.spark.build.date=$(BUILD_DATE) \
    ro.spark.buildtype=$(SPARK_BUILD_TYPE) \
    ro.spark.fingerprint=$(ROM_FINGERPRINT) \
    ro.spark.version=$(SPARK_VERSION) \
    ro.modversion=$(SPARK_VERSION)
