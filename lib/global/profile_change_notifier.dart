import 'package:flutter/material.dart';
import 'profile.dart';
import 'global.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class ThemeModel extends ProfileChangeNotifier {
  bool get enDarkMode => _profile.enBrightnessDark;
  int get color => _profile.color;
  int get customColor => _profile.customColor;

  set enDarkMode(bool enable) {
    if (enable != enDarkMode) {
      _profile.enBrightnessDark = enable;
      notifyListeners();
    }
  }

  set color(int value) {
    if (value != color) {
      _profile.color = value;
      notifyListeners();
    }
  }

  set customColor(int value) {
    if (value != customColor) {
      _profile.customColor = value;
      notifyListeners();
    }
  }
}

class SettingModel extends ProfileChangeNotifier {
  bool get enTabBar => _profile.enTabBar;
  bool get enAutoRefresh => _profile.enAutoRefresh;
  bool get enFullScreen => _profile.enFullScreen;
  bool get enVolumeControl => _profile.enVolumeControl;
  bool get enFlippingAnimation => _profile.enFlippingAnimation;

  set enTabBar(bool enable) {
    if (enable != enTabBar) {
      _profile.enTabBar = enable;
      notifyListeners();
    }
  }

  set enAutoRefresh(bool enable) {
    if (enable != enAutoRefresh) {
      _profile.enAutoRefresh = enable;
      notifyListeners();
    }
  }

  set enFullScreen(bool enable) {
    if (enable != enFullScreen) {
      _profile.enFullScreen = enable;
      notifyListeners();
    }
  }

  set enVolumeControl(bool enable) {
    if (enable != enTabBar) {
      _profile.enVolumeControl = enable;
      notifyListeners();
    }
  }

  set enFlippingAnimation(bool enable) {
    if (enable != enTabBar) {
      _profile.enFlippingAnimation = enable;
      notifyListeners();
    }
  }
}

class PageModel with ChangeNotifier {
  PageController _pageController;
  PageController get pageController => _pageController;
  int _currentIndex;
  int get currentIndex => _currentIndex;

  PageModel() {
    _currentIndex = 0;
    _pageController = PageController();
  }

  void changePage(int index, [bool needUpdatePage = true]) async {
    _currentIndex = index;
    if (needUpdatePage) {
      await _pageController.animateToPage(index,
          duration: Duration(microseconds: 10), curve: Curves.ease);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
