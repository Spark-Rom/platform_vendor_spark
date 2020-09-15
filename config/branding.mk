GET_VERSION := vendor/spark/build/tools/getversion.py
SPARK_STATUS := $(shell $(GET_VERSION) status)
BUILD_TYPE := $(shell $(GET_VERSION) buildtype)
SPARK_BRANDING_VERSION := $(BUILD_TYPE)
SPARK_VERSION := $(shell $(GET_VERSION) version)

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif
