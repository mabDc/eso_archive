class Profile {
  Profile();

  // home page settings
  bool enTabBar = true;
  bool enAutoRefresh = false;
  // content settings
  bool enFullScreen = true;
  bool enVolumeControl = false;
  bool enFlippingAnimation = false;
  // theme settings
  bool enBrightnessDark = false;
  int color = 0xff009688;
  int customColor = 0xff009688;
  // other settings
  //String download path;

  Profile.copyFrom(Profile other) {
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
    if (other.color != null) {
      color = other.color;
    }
    if (other.customColor != null) {
      customColor = other.customColor;
    }
  }

  Profile.safeFromJson(Map<String, dynamic> json) {
    final defaultProfile = Profile();
    enTabBar = json['enTabBar'] ?? defaultProfile.enTabBar;
    enAutoRefresh = json['enAutoRefresh'] ?? defaultProfile.enAutoRefresh;
    enFullScreen = json['enFullScreen'] ?? defaultProfile.enFullScreen;
    enVolumeControl = json['enVolumeControl'] ?? defaultProfile.enVolumeControl;
    enFlippingAnimation =
        json['enFlippingAnimation'] ?? defaultProfile.enFlippingAnimation;
    enBrightnessDark =
        json['enBrightnessDark'] ?? defaultProfile.enBrightnessDark;
    color = json['colorValue'] ?? defaultProfile.color;
    customColor =
        json['customColorValue'] ?? defaultProfile.customColor;
  }

  Profile.fromJson(Map<String, dynamic> json)
      : enTabBar = json['enTabBar'],
        enAutoRefresh = json['enAutoRefresh'],
        enFullScreen = json['enFullScreen'],
        enVolumeControl = json['enVolumeControl'],
        enFlippingAnimation = json['enFlippingAnimation'],
        enBrightnessDark = json['enBrightnessDark'],
        color = json['colorValue'],
        customColor = json['customColorValue'];

  Map<String, dynamic> toJson() => {
        'enTabBar': enTabBar,
        'enAutoRefresh': enAutoRefresh,
        'enFullScreen': enFullScreen,
        'enVolumeControl': enVolumeControl,
        'enFlippingAnimation': enFlippingAnimation,
        'enBrightnessDark': enBrightnessDark,
        'colorValue': color,
        'customColorValue': customColor,
      };
}
