# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni \
    wellbeingconf \
    googleconf

# Required packages
PRODUCT_PACKAGES += \
    ThemePicker \
    SparkThemesStub \
    TurboPrebuilt

# Extra tools in Octavi
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs
