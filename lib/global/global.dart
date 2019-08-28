import 'dart:convert';
import 'dart:io';

import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:path_provider/path_provider.dart';

import 'option.dart';

class Global {
  static final Global _config = new Global._internal();

  factory Global() {
    return _config;
  }

  Global._internal();

  String _localPath;
  String _optionFile = 'option.json';
  String _keywordFile = 'history.json';
  dynamic setTheme;
  JSContext jsContext;
  List<dynamic> keyword = <dynamic>[];
  Setting option = Setting();

  Future<void> init() async {
    _localPath = await _getLocalPath();
    try {
      String optionString = await File('$_localPath/$_optionFile').readAsString();
      option = Setting.safeFromJson(jsonDecode(optionString));
    } catch (e) {
      print(e.toString());
    }
    try {
      String keywordString = await File('$_localPath/$_keywordFile').readAsString();
      keyword = jsonDecode(keywordString) as List<dynamic>;
    } catch (e) {
      print(e.toString());
    }
    return;
  }

  Future<File> saveOption(){
    return File('$_localPath/$_optionFile').writeAsString(jsonEncode(option.toJson()));
  }
  
  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
