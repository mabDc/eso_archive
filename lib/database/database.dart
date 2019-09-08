import 'dart:async';

import 'rule.dart';
import 'rule_dao.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Rule])
abstract class EsoDatabase extends FloorDatabase {
  RuleDao get ruleDao;
}