SPARK_STATUS = Stable
SPARK_BUILD_VARIANT := vanilla
SPARK_BRANDING_VERSION := Fire
SPARK_VERSION := 1.0

ifndef SPARK_BUILD_TYPE
    SPARK_BUILD_TYPE := Unofficial
endif

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
LIST := $(shell cat vendor/spark/spark.devices)

ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
    ifeq ($(filter-out Official OFFICIAL, $(SPARK_BUILD_TYPE)),)
        ifeq ($(SPARK_BUILD_TYPE), Official)
          BUILD_TYPE := Official
        endif
        ifeq ($(SPARK_BUILD_TYPE), OFFICIAL)
          BUILD_TYPE := OFFICIAL
        endif
    endif
else
    ifeq ($(filter-out Official OFFICIAL, $(SPARK_BUILD_TYPE)),)
      $(error "Invalid SPARK_BUILD_TYPE!")
    endif
endif

# Gapps
ifeq ($(WITH_GAPPS), true)
    $(call inherit-product, vendor/gapps/config.mk)
    SPARK_BUILD_VARIANT := gapps
endif

TARGET_PRODUCT_SHORT := $(subst spark_,,$(TARGET_PRODUCT))

SPARK_VERSION := Spark-v$(SPARK_BRANDING_VERSION)-$(TARGET_PRODUCT_SHORT)-$(SPARK_BUILD_TYPE)-$(SPARK_BUILD_VARIANT)-$(shell date -u +%Y%m%d)

PRODUCT_GENERIC_PROPERTIES += \
  ro.build.project=spark \
  ro.spark.version=$(SPARK_VERSION) \
  ro.spark.status=$(SPARK_STATUS) \
  ro.spark.branding.version=$(SPARK_BRANDING_VERSION) \
  ro.spark.build.variant=$(SPARK_BUILD_VARIANT)
