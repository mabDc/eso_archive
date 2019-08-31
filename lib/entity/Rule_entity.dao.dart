// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// EntityGenerator
// **************************************************************************

///rule表
import 'package:yun_dao/db_manager.dart';
import 'package:yun_dao/entity.dart';
import 'package:eso/entity/Rule_entity.dart';
import 'package:yun_dao/Dao.dart';
import 'package:yun_dao/query.dart';

class RuleDao extends Dao<Rule> {
  static List propertyMapList = [
    {
      "name": "id",
      "type": {"value": "INT"},
      "isPrimary": true
    },
    {
      "name": "name",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "host",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "contentType",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "discoverUrl",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "discoverItems",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "searchUrl",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "searchItems",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "detailUrl",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "detailItems",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "chapterUrl",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "chapterItems",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "contentUrl",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "contentItems",
      "type": {"value": "TEXT"},
      "isPrimary": false
    },
    {
      "name": "enCheerio",
      "type": {"value": "INT"},
      "isPrimary": false
    },
    {
      "name": "enMultiRoads",
      "type": {"value": "INT"},
      "isPrimary": false
    },
    {
      "name": "enable",
      "type": {"value": "INT"},
      "isPrimary": false
    }
  ];

  ///初始化数据库
  static Future<bool> init() async {
    DBManager dbManager = DBManager();
    List<Map> maps = await await dbManager.db
        .query("sqlite_master", where: " name = 'rule'");
    if (maps == null || maps.length == 0) {
      List<Property> propertyList = List();
      for (Map map in propertyMapList) {
        propertyList.add(Property.fromJson(map));
      }
      dbManager.db.execute(
          "CREATE TABLE rule(id  INT PRIMARY KEY,name  TEXT,host  TEXT,contentType  TEXT,discoverUrl  TEXT,discoverItems  TEXT,searchUrl  TEXT,searchItems  TEXT,detailUrl  TEXT,detailItems  TEXT,chapterUrl  TEXT,chapterItems  TEXT,contentUrl  TEXT,contentItems  TEXT,enCheerio  INT,enMultiRoads  INT,enable  INT)");
    }
    return true;
  }

  ///查询表中所有数据
  static Future<List<Rule>> queryAll() async {
    DBManager dbManager = DBManager();
    List<Rule> entityList = List();
    RuleDao entityDao = RuleDao();
    List<Map> maps = await dbManager.db.query("rule");
    for (Map map in maps) {
      entityList.add(entityDao.formMap(map));
    }
    return entityList;
  }

  ///增加一条数据
  static Future<bool> insert(Rule entity) async {
    DBManager dbManager = DBManager();
    RuleDao entityDao = RuleDao();
    await dbManager.db.insert("rule", entityDao.toMap(entity));
    return true;
  }

  ///增加多条条数据
  static Future<bool> insertList(List<Rule> entityList) async {
    DBManager dbManager = DBManager();
    List<Map> maps = List();
    RuleDao entityDao = RuleDao();
    for (Rule entity in entityList) {
      maps.add(entityDao.toMap(entity));
    }
    await dbManager.db.rawInsert("rule", maps);
    return true;
  }

  ///更新数据
  static Future<int> update(Rule entity) async {
    DBManager dbManager = DBManager();
    RuleDao entityDao = RuleDao();
    return await dbManager.db.update("rule", entityDao.toMap(entity),
        where: 'id = ?', whereArgs: [entity.id]);
  }

  ///删除数据
  static Future<int> delete(Rule entity) async {
    DBManager dbManager = DBManager();
    return await dbManager.db
        .delete("rule", where: 'id = ?', whereArgs: [entity.id]);
  }

  ///map转为entity
  @override
  Rule formMap(Map map) {
    Rule entity = Rule();
    entity.id = map['id'];
    entity.name = map['name'];
    entity.host = map['host'];
    entity.contentType = map['contentType'];
    entity.discoverUrl = map['discoverUrl'];
    entity.discoverItems = map['discoverItems'];
    entity.searchUrl = map['searchUrl'];
    entity.searchItems = map['searchItems'];
    entity.detailUrl = map['detailUrl'];
    entity.detailItems = map['detailItems'];
    entity.chapterUrl = map['chapterUrl'];
    entity.chapterItems = map['chapterItems'];
    entity.contentUrl = map['contentUrl'];
    entity.contentItems = map['contentItems'];
    entity.enCheerio = map['enCheerio']==1?true:false;
    entity.enMultiRoads = map['enMultiRoads']==1?true:false;
    entity.enable = map['enable']==1?true:false;
    return entity;
  }

  ///entity转为map
  @override
  Map toMap(Rule entity) {
    var map = Map<String, dynamic>();
    map['id'] = entity.id;
    map['name'] = entity.name;
    map['host'] = entity.host;
    map['contentType'] = entity.contentType;
    map['discoverUrl'] = entity.discoverUrl;
    map['discoverItems'] = entity.discoverItems;
    map['searchUrl'] = entity.searchUrl;
    map['searchItems'] = entity.searchItems;
    map['detailUrl'] = entity.detailUrl;
    map['detailItems'] = entity.detailItems;
    map['chapterUrl'] = entity.chapterUrl;
    map['chapterItems'] = entity.chapterItems;
    map['contentUrl'] = entity.contentUrl;
    map['contentItems'] = entity.contentItems;
    map['enCheerio'] = entity.enCheerio?1:0;
    map['enMultiRoads'] = entity.enMultiRoads?1:0;
    map['enable'] = entity.enable?1:0;
    return map;
  }

  @override
  String getTableName() {
    return "rule";
  }

  static QueryProperty ID = QueryProperty(name: 'id');
  static QueryProperty NAME = QueryProperty(name: 'name');
  static QueryProperty HOST = QueryProperty(name: 'host');
  static QueryProperty CONTENTTYPE = QueryProperty(name: 'contentType');
  static QueryProperty DISCOVERURL = QueryProperty(name: 'discoverUrl');
  static QueryProperty DISCOVERITEMS = QueryProperty(name: 'discoverItems');
  static QueryProperty SEARCHURL = QueryProperty(name: 'searchUrl');
  static QueryProperty SEARCHITEMS = QueryProperty(name: 'searchItems');
  static QueryProperty DETAILURL = QueryProperty(name: 'detailUrl');
  static QueryProperty DETAILITEMS = QueryProperty(name: 'detailItems');
  static QueryProperty CHAPTERURL = QueryProperty(name: 'chapterUrl');
  static QueryProperty CHAPTERITEMS = QueryProperty(name: 'chapterItems');
  static QueryProperty CONTENTURL = QueryProperty(name: 'contentUrl');
  static QueryProperty CONTENTITEMS = QueryProperty(name: 'contentItems');
  static QueryProperty ENCHEERIO = QueryProperty(name: 'enCheerio');
  static QueryProperty ENMULTIROADS = QueryProperty(name: 'enMultiRoads');
  static QueryProperty ENABLE = QueryProperty(name: 'enable');

  static Query queryBuild() {
    Query query = Query(RuleDao());
    return query;
  }
}

///查询条件生成
class QueryProperty {
  String name;
  QueryProperty({this.name});
  QueryCondition equal(dynamic queryValue) {
    QueryCondition queryCondition = QueryCondition();
    queryCondition.key = name;
    queryCondition.value = queryValue;
    return queryCondition;
  }
}
