# Fonts
LOCAL_PATH := vendor/spark/fonts
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/ttf,$(TARGET_COPY_OUT_PRODUCT)/fonts)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# Clock Fonts
PRODUCT_PACKAGES += \
    ClockFontAccuratistOverlay \
    ClockFontApiceOverlay \
    ClockFontAudimatOverlay \
    ClockFontBariolOverlay \
    ClockFontCoconOverlay \
    ClockFontComfortaaOverlay \
    ClockFontComicSansOverlay \
    ClockFontCoolstoryOverlay \
    ClockFontExotwoOverlay \
    ClockFontEvolveSansOverlay \
    ClockFontFluidSansOverlay \
    ClockFontGoogleSansOverlay \
    ClockFontGeometosOverlay \
    ClockFontHarmonySansOverlay \
    ClockFontJTLeonorOverlay \
    ClockFontLinotteOverlay \
    ClockFontMiSansOverlay \
    ClockFontNokiaPureOverlay \
    ClockFontNothingDotHeadlineOverlay \
    ClockFontOneplusSansOverlay \
    ClockFontOneplusSlateOverlay \
    ClockFontOppoSansOverlay \
    ClockFontProductSansVHOverlay \
    ClockFontRobotoCondensedOverlay \
    ClockFontRosemaryOverlay \
    ClockFontRubikOverlay \
    ClockFontSanFranciscoDisplayProSourceOverlay \
    ClockFontSamsungOneOverlay \
    ClockFontSimpleDaySourceOverlay \
    ClockFontSonySketchOverlay \

# Fonts
PRODUCT_PACKAGES += \
    FontAccuratistOverlay \
    FontBariolOverlay \
    FontCoconOverlay \
    FontComfortaaOverlay \
    FontComicSansOverlay \
    FontCoolstoryOverlay \
    FontExotwoOverlay \
    FontEvolveSansOverlay \
    FontFluidSansOverlay \
    FontGoogleSansOverlay \
    FontHarmonySansOverlay \
    FontJTLeonorOverlay \
    FontLinotteOverlay \
    FontMiSansOverlay \
    FontNokiaPureOverlay \
    FontNothiingDotOverlay \
    FontNothingDotHeadlineOverlay \
    FontOneplusSansOverlay \
    FontOneplusSlateOverlay \
    RobotoFallback-VF.ttf \
    FontOppoSansOverlay \
    FontProductSansVHOverlay \
    FontRobotoCondensedOverlay \
    FontRosemaryOverlay \
    FontRubikOverlay \
    FontSanFranciscoDisplayProSourceOverlay \
    FontSamsungOneOverlay \
    FontSimpleDaySourceOverlay \
    FontSonySketchOverlay
