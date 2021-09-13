SPARK_STATUS := 7.0
SPARK_BUILD_VARIANT := vanilla
SPARK_BRANDING_VERSION := Mist

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
    $(call inherit-product, vendor/gms/products/gms.mk)
    SPARK_BUILD_VARIANT := gapps
endif

BUILD_DATE_TIME := $(BUILD_TIME)$(BUILD_DATE)

TARGET_PRODUCT_SHORT := $(subst spark_,,$(TARGET_PRODUCT))

SPARK_VERSION := Spark-v$(SPARK_BRANDING_VERSION)-$(TARGET_PRODUCT_SHORT)-$(SPARK_BUILD_TYPE)-$(SPARK_BUILD_VARIANT)-$(shell date -u +%H%M)-$(shell date -u +%Y%m%d)

