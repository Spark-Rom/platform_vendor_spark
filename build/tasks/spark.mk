# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
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

# -----------------------------------------------------------------
# Spark OTA update package

# Build system colors

ifneq ($(BUILD_WITH_COLORS),0)
	CL_RED="\033[31m"
	CL_GRN="\033[32m"
	CL_YLW="\033[33m"
	CL_BLU="\033[34m"
	CL_MAG="\033[35m"
	CL_CYN="\033[36m"
	CL_RST="\033[0m"
endif

SPARK_TARGET_PACKAGE := $(PRODUCT_OUT)/$(SPARK_VERSION).zip

MD5 := prebuilts/build-tools/path/$(HOST_OS)-x86/md5sum

.PHONY: spark

spark: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(SPARK_TARGET_PACKAGE)
	$(hide) $(MD5) $(SPARK_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(SPARK_TARGET_PACKAGE).md5
	@echo "Package Complete: $(SPARK_TARGET_PACKAGE)" >&2
	echo -e ${CL_RED}         "  _________                   __             ________    _________	"${CL_RST}
	echo -e ${CL_YLW}         " /   _____/__________ _______|  | __         \_____  \  /   _____/	"${CL_RST}
	echo -e ${CL_RED}         " \_____  \\____ \__  \\_  __ \  |/ /  ______  /   |   \ \_____  \	"${CL_RST}
	echo -e ${CL_YLW}         " /        \  |_> > __ \|  | \/    <  /_____/ /    |    \/        \	"${CL_RST}
	echo -e ${CL_YLW}         "/_______  /   __(____  /__|  |__|_ \         \_______  /_______  /	"${CL_RST}
	echo -e ${CL_YLW}         "        \/|__|       \/           \/                 \/        \/	"${CL_RST}
	echo -e ${CL_BLD}${CL_CYN}"====================================================="${CL_RST}
	echo -e ${CL_BLD}${CL_RED}"Zip: "${CL_YLW} $(SPARK_TARGET_PACKAGE) ${CL_RST}
	echo -e ${CL_BLD}${CL_RED}"Size:"${CL_YLW}" `du -sh $(SPARK_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	echo -e ${CL_BLD}${CL_CYN}"====================================================="${CL_RST}
