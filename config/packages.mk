# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni \
    wellbeingconf \
    googleconf

# Required packages
PRODUCT_PACKAGES += \
    Launcher3 \
    ThemePicker \
    SoftAPManager \
    SparkThemesStub \
    QuickAccessWallet \
    Updater \
    Flipendo \
    StitchImage \
    StitchImageService \
    SimpleDeviceConfig \
    SoundPickerPrebuilt \
    OmniJaws

ifeq ($(WITH_LAWNCHAIR), true)
include vendor/spark/packages/apps/Lawnchair/lawnchair.mk
endif

ifneq ($(WITH_GAPPS), true)
PRODUCT_PACKAGES += \
     ViaBrowser
endif

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
    e2fsck \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mke2fs \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs
