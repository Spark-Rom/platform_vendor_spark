# Copyright (C) 2016-2017 AOSiP
# Copyright (C) 2020 Fluid
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
SPARK_NUM_VER_PRIMARY := 12
SPARK_NUM_VER_SECONDARY := 6

TARGET_PRODUCT_SHORT := $(subst spark_,,$(SPARK_BUILD_TYPE))

SPARK_BUILD_TYPE ?= UNOFFICIAL

# Only include Updater for official, weeklies, CI and nightly builds
ifeq ($(filter-out OFFICIAL Official WEEKLIES NIGHTLY CI,$(SPARK_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updates
endif

# Sign builds if building an official, weekly, CI and nightly build
ifeq ($(filter-out OFFICIAL WEEKLIES NIGHTLY CI,$(SPARK_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(KEYS_LOCATION)
endif

# Set all versions
BUILD_DATE := $(shell date -u +%Y%m%d)
BUILD_TIME := $(shell date -u +%H%M)
SPARK_BUILD_VERSION := $(SPARK_NUM_VER_PRIMARY).$(SPARK_NUM_VER_SECONDARY)
SPARK_VERSION := $(SPARK_BUILD_VERSION)-$(SPARK_BUILD_TYPE)-$(SPARK_BUILD)-$(BUILD_DATE)
ifeq ($(WITH_GAPPS), true)
SPARK_VERSION := $(SPARK_VERSION)-gapps
endif
ROM_FINGERPRINT := Spark/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BUILD_TIME)
SPARK_DISPLAY_VERSION := $(SPARK_VERSION)
RELEASE_TYPE := $(SPARK_BUILD_TYPE)
