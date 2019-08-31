import 'dart:convert';
import 'dart:io';

import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:path_provider/path_provider.dart';

import 'setting.dart';

import '../rule/video_example.dart';
import '../rule/thumbnail_example.dart';
import '../utils/rule.dart';

class Global {
  static final Global _config = new Global._internal();

  factory Global() {
    return _config;
  }

  Global._internal();

  String _localPath;
  final _settingFile = 'setting.json';
  final _keywordFile = 'keyword.json';
  // final _historyFile = 'history.json';
  final _ruleFile = 'rule.json';
  final cheerioFile = 'lib/js/cheerio.js';
  dynamic setTheme;
  JSContext jsContext;
  List<dynamic> keyword = <dynamic>[];
  List<dynamic> history = <dynamic>[];
  //List<dynamic> rule = <dynamic>[];
  Map<dynamic,dynamic> rule = Map<dynamic,dynamic>();
  Setting setting = Setting();

  Future<void> init() async {
    _localPath = await _getLocalPath();
    try {
      String settingString =
          await File('$_localPath/$_settingFile').readAsString();
      setting = Setting.safeFromJson(jsonDecode(settingString));
    } catch (e) {
      //print(e.toString());
    }
    try {
      String keywordString =
          await File('$_localPath/$_keywordFile').readAsString();
      keyword = jsonDecode(keywordString) as List<dynamic>;
    } catch (e) {
      //print(e.toString());
    }
    try {
      String ruleString =
          await File('$_localPath/$_ruleFile').readAsString();
      rule = jsonDecode(ruleString);
    } catch (e) {
      rule.addAll({
        'VideoExample':VideoExample().rule,
        'ThumbnailExample':ThumbnailExample().rule
      });
      //print(e.toString());
    }
    return;
  }
  
  Future<File> saveRule() {
    return File('$_localPath/$_ruleFile')
        .writeAsString(jsonEncode(rule));
  }
  Future<File> saveSetting() {
    return File('$_localPath/$_settingFile')
        .writeAsString(jsonEncode(setting.toJson()));
  }

  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
