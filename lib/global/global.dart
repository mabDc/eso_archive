import 'dart:convert';

import '../database/rule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database.dart';
import '../database/rule_dao.dart';
import '../database/shelf_item_dao.dart';
import 'profile.dart';
import '../rule/neizhi.dart';

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  static const cheerioFile = 'lib/assets/cheerio.min.js';
  static const md5File = 'lib/assets/md5.min.js';
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static RuleDao _ruleDao;
  static RuleDao get ruleDao => _ruleDao;
  static ShelfItemDao _shelfItemDao;
  static ShelfItemDao get shelfItemDao => _shelfItemDao;

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
    _shelfItemDao = _database.shelfItemDao;

    String ruleversion = _prefs.getString("ruleversion");
    if(ruleversion == null || ruleversion != 'zhongwen'){
      await _ruleDao.insertOrUpdateRules(Neizhi.rules.map((json)=>Rule.safeFromJson(json)).toList());
      await _prefs.setString("ruleversion", 'zhongwen');
    }
  }

  static Future<bool> saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
