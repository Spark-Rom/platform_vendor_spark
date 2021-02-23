SPARK_STATUS = BETA
SPARK_BUILD_VARIANT := vanilla

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

SPARK_VERSION := Spark-v$(SPARK_STATUS)-$(TARGET_PRODUCT_SHORT)-$(SPARK_BUILD_TYPE)-$(SPARK_BUILD_VARIANT)-$(shell date -u +%Y%m%d)

SPARK_BRANDING_VERSION = Fire

PRODUCT_GENERIC_PROPERTIES += \
  ro.build.project=spark \
  ro.spark.version=1.0 \
  ro.spark.status=Beta \
  ro.spark.branding.version=Fire \
  ro.spark.build.variant=$(SPARK_BUILD_VARIANT)
