import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../database/database.dart';
import '../database/rule_dao.dart';
import 'profile.dart';

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  static const cheerioFile = 'lib/js/cheerio.js';
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static RuleDao _ruleDao;
  static RuleDao get ruleDao => _ruleDao;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    String _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.safeFromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    final _database =
        await $FloorEsoDatabase.databaseBuilder('eso_database.db').build();
    _ruleDao = _database.ruleDao;

  }

  static Future<bool> saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
