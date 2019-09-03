import 'dart:convert';
import 'profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  static const cheerioFile = 'lib/js/cheerio.js';
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.safeFromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<bool> saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
