class Setting {
  Setting();

  // home page settings
  bool enTabBar = true;
  bool enAutoRefresh = false;
  // read settings
  bool enFullScreen = true;
  bool enVolumeControl = false;
  bool enFlippingAnimation = false;
  // theme settings
  bool enBrightnessDark = false;
  int colorValue = 0xff009688;
  int customColorValue = 0xff009688;
  // other settings
  //String download path;

  Setting.copyFrom(Setting other) {
    if (other.enTabBar != null) {
      enTabBar = other.enTabBar;
    }
    if (other.enAutoRefresh != null) {
      enAutoRefresh = other.enAutoRefresh;
    }
    if (other.enFullScreen != null) {
      enFullScreen = other.enFullScreen;
    }
    if (other.enVolumeControl != null) {
      enVolumeControl = other.enVolumeControl;
    }
    if (other.enFlippingAnimation != null) {
      enFlippingAnimation = other.enFlippingAnimation;
    }
    if (other.enBrightnessDark != null) {
      enBrightnessDark = other.enBrightnessDark;
    }
    if (other.colorValue != null) {
      colorValue = other.colorValue;
    }
    if (other.customColorValue != null) {
      customColorValue = other.customColorValue;
    }
  }

  Setting.safeFromJson(Map<String, dynamic> json) {
    final defaultSetting = Setting();
    enTabBar = json['enTabBar'] ?? defaultSetting.enTabBar;
    enAutoRefresh = json['enAutoRefresh'] ?? defaultSetting.enAutoRefresh;
    enFullScreen = json['enFullScreen'] ?? defaultSetting.enFullScreen;
    enVolumeControl = json['enVolumeControl'] ?? defaultSetting.enVolumeControl;
    enFlippingAnimation =
        json['enFlippingAnimation'] ?? defaultSetting.enFlippingAnimation;
    enBrightnessDark =
        json['enBrightnessDark'] ?? defaultSetting.enBrightnessDark;
    colorValue = json['colorValue'] ?? defaultSetting.colorValue;
    customColorValue =
        json['customColorValue'] ?? defaultSetting.customColorValue;
  }

  Setting.fromJson(Map<String, dynamic> json)
      : enTabBar = json['enTabBar'],
        enAutoRefresh = json['enAutoRefresh'],
        enFullScreen = json['enFullScreen'],
        enVolumeControl = json['enVolumeControl'],
        enFlippingAnimation = json['enFlippingAnimation'],
        enBrightnessDark = json['enBrightnessDark'],
        colorValue = json['colorValue'],
        customColorValue = json['customColorValue'];

  Map<String, dynamic> toJson() => {
        'enTabBar': enTabBar,
        'enAutoRefresh': enAutoRefresh,
        'enFullScreen': enFullScreen,
        'enVolumeControl': enVolumeControl,
        'enFlippingAnimation': enFlippingAnimation,
        'enBrightnessDark': enBrightnessDark,
        'colorValue': colorValue,
        'customColorValue': customColorValue,
      };
}
