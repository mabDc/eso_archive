import 'dart:convert';
import 'dart:io';

import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:path_provider/path_provider.dart';

import 'setting.dart';

class Global {
  static final Global _config = new Global._internal();

  factory Global() {
    return _config;
  }

  Global._internal();

  String _localPath;
  final _optionFile = 'option.json';
  final _keywordFile = 'keyword.json';
  final _historyFile = 'history.json';
  final _ruleFile = 'rule.json';
  final cheerioFile = 'lib/js/cheerio.js';
  dynamic setTheme;
  JSContext jsContext;
  List<dynamic> keyword = <dynamic>[];
  List<dynamic> history = <dynamic>[];
  List<dynamic> rule = <dynamic>[];
  Setting option = Setting();

  Future<void> init() async {
    _localPath = await _getLocalPath();
    try {
      String optionString =
          await File('$_localPath/$_optionFile').readAsString();
      option = Setting.safeFromJson(jsonDecode(optionString));
    } catch (e) {
      print(e.toString());
    }
    try {
      String keywordString =
          await File('$_localPath/$_keywordFile').readAsString();
      keyword = jsonDecode(keywordString) as List<dynamic>;
    } catch (e) {
      print(e.toString());
    }
    return;
  }

  Future<File> saveOption() {
    return File('$_localPath/$_optionFile')
        .writeAsString(jsonEncode(option.toJson()));
  }

  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
