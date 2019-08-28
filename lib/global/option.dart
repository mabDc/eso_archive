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
  int materialColorIndex = 0;

  Setting.deaultOption() {
    enTabBar = true;
    enAutoRefresh = false;
    enFullScreen = true;
    enVolumeControl = false;
    enFlippingAnimation = false;
    enBrightnessDark = false;
    materialColorIndex = 0;
  }

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
    if (other.materialColorIndex != null) {
      materialColorIndex = other.materialColorIndex;
    }
  }

  Setting.safeFromJson(Map<String, dynamic> json) {
    final defaultOption = Setting.deaultOption();
    enTabBar = json['enTabBar'] ?? defaultOption.enTabBar;
    enAutoRefresh = json['enAutoRefresh'] ?? defaultOption.enAutoRefresh;
    enFullScreen = json['enFullScreen'] ?? defaultOption.enFullScreen;
    enVolumeControl = json['enVolumeControl'] ?? defaultOption.enVolumeControl;
    enFlippingAnimation =
        json['enFlippingAnimation'] ?? defaultOption.enFlippingAnimation;
    enBrightnessDark =
        json['enBrightnessDark'] ?? defaultOption.enBrightnessDark;
    materialColorIndex =
        json['materialColorIndex'] ?? defaultOption.materialColorIndex;
  }

  Setting.fromJson(Map<String, dynamic> json)
      : enTabBar = json['enTabBar'],
        enAutoRefresh = json['enAutoRefresh'],
        enFullScreen = json['enFullScreen'],
        enVolumeControl = json['enVolumeControl'],
        enFlippingAnimation = json['enFlippingAnimation'],
        enBrightnessDark = json['enBrightnessDark'],
        materialColorIndex = json['materialColorIndex'];

  Map<String, dynamic> toJson() => {
        'enTabBar': enTabBar,
        'enAutoRefresh': enAutoRefresh,
        'enFullScreen': enFullScreen,
        'enVolumeControl': enVolumeControl,
        'enFlippingAnimation': enFlippingAnimation,
        'enBrightnessDark': enBrightnessDark,
        'materialColorIndex': materialColorIndex,
      };
}
