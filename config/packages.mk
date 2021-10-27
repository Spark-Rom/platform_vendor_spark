# Spark packages
PRODUCT_PACKAGES += \
    ThemePicker \
    QuickAccessWallet \
    StitchImage \
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
    wget \
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

