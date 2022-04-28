# Spark packages
PRODUCT_PACKAGES += \
    ThemePicker \
    SparkWallpaperStub \
    QuickAccessWallet \
    wellbeingconf \
    googleconf

ifneq ($(TARGET_NO_PREBUILT_CAMERA),true)
PRODUCT_PACKAGES += \
    Camera
endif


# Extra tools in Spark
PRODUCT_PACKAGES += \
    7z \
    bash \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    setcap \
    unrar \
    vim \
    zip

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

