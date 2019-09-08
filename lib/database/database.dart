import 'dart:async';

import 'rule.dart';
import 'rule_dao.dart';
import 'shelf_item.dart';
import 'shelf_item_dao.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 2, entities: [Rule, ShelfItem])
abstract class EsoDatabase extends FloorDatabase {
  RuleDao get ruleDao;
  ShelfItemDao get shelfItemDao;
}