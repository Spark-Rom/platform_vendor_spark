SPARK_STATUS = BETA

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

TARGET_PRODUCT_SHORT := $(subst spark_,,$(TARGET_PRODUCT))

SPARK_VERSION := Spark-v$(SPARK_STATUS)-$(TARGET_PRODUCT_SHORT)-$(shell date -u +%Y%m%d)-$(SPARK_BUILD_TYPE)

SPARK_BRANDING_VERSION := $(SPARK_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.build.project=spark \
  ro.spark.version=$(SPARK_VERSION) \
  ro.spark.status=$(SPARK_STATUS) \
  ro.spark.branding.version=$(SPARK_BRANDING_VERSION)
