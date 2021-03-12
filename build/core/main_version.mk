ADDITIONAL_BUILD_PROPERTIES += \
  ro.build.project=spark \
  ro.spark.build.type=$(SPARK_BUILD_TYPE) \
  ro.spark.version=$(SPARK_VERSION) \
  ro.spark.status=$(SPARK_STATUS) \
  ro.spark.branding.version=$(SPARK_BRANDING_VERSION) \
  ro.spark.build.variant=$(SPARK_BUILD_VARIANT)
