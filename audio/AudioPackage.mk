#
# Audio Package - from Nothing OS
#
# Include this file in a product makefile to include these audio files
#
#

LOCAL_PATH:= vendor/spark/audio

# Nothing OS Audio Files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/ui/camera_click.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/Spark_camera_click.ogg \
	$(LOCAL_PATH)/ui/Dock.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkDock.ogg \
	$(LOCAL_PATH)/ui/Effect_Tick.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/Spark_Effect_Tick.ogg \
	$(LOCAL_PATH)/ui/InCallNotification.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkInCallNotification.ogg \
	$(LOCAL_PATH)/ui/KeypressDelete.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkKeypressDelete.ogg \
	$(LOCAL_PATH)/ui/KeypressInvalid.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkKeypressInvalid.ogg \
	$(LOCAL_PATH)/ui/KeypressReturn.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkKeypressReturn.ogg \
	$(LOCAL_PATH)/ui/KeypressSpacebar.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkKeypressSpacebar.ogg \
	$(LOCAL_PATH)/ui/screenshot.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkScreenshot.ogg \
	$(LOCAL_PATH)/ui/Trusted.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkTrusted.ogg \
	$(LOCAL_PATH)/ui/Undock.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkUndock.ogg \
	$(LOCAL_PATH)/ui/WirelessChargingStarted.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkWirelessChargingStarted.ogg

# Samsung S21 FE Audio Files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/ui/Lock.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkLock.ogg \
	$(LOCAL_PATH)/ui/Unlock.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkUnlock.ogg \
	$(LOCAL_PATH)/ui/LowBattery.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ui/SparkLowBattery.ogg
