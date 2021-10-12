include vendor/spark/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/spark/config/BoardConfigQcom.mk
endif

include vendor/spark/config/BoardConfigSoong.mk
