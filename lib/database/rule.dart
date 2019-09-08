import 'package:floor/floor.dart';

@entity
class Rule {
  @primaryKey
  int id = DateTime.now().microsecondsSinceEpoch;

  bool enable = true;
  String name = '';
  String host = '';
  String contentType = 'thumbnail';
  bool enCheerio = false;
  String discoverUrl = '';
  String discoverItems = '';
  String searchUrl = '';
  String searchItems = '';
  String detailUrl = '';
  String detailItems = '';
  bool enMultiRoads = false;
  String chapterUrl = '';
  String chapterItems = '';
  String contentUrl = '';
  String contentItems = '';

  Rule(
    this.id,
    this.enable,
    this.name,
    this.host,
    this.contentType,
    this.enCheerio,
    this.discoverUrl,
    this.discoverItems,
    this.searchUrl,
    this.searchItems,
    this.detailUrl,
    this.detailItems,
    this.enMultiRoads,
    this.chapterUrl,
    this.chapterItems,
    this.contentUrl,
    this.contentItems,
  );

  Rule.newRule() {
    id = DateTime.now().microsecondsSinceEpoch;
    enable = true;
    name = '';
    host = '';
    contentType = 'thumbnail';
    enCheerio = false;
    discoverUrl = '';
    discoverItems = '';
    searchUrl = '';
    searchItems = '';
    detailUrl = '';
    detailItems = '';
    enMultiRoads = false;
    chapterUrl = '';
    chapterItems = '';
    contentUrl = '';
    contentItems = '';
  }

  Rule.safeFromJson(Map<dynamic, dynamic> json) {
    final defaultRule = Rule.newRule();
    id = json['id'] ?? defaultRule.id;
    enable = json['enable'] ?? defaultRule.enable;
    name = json['name'] ?? defaultRule.name;
    host = json['host'] ?? defaultRule.host;
    contentType = json['contentType'] ?? defaultRule.contentType;
    enCheerio = json['enCheerio'] ?? defaultRule.enCheerio;
    discoverUrl = json['discoverUrl'] ?? defaultRule.discoverUrl;
    discoverItems = json['discoverItems'] ?? defaultRule.discoverItems;
    searchUrl = json['searchUrl'] ?? defaultRule.searchUrl;
    searchItems = json['searchItems'] ?? defaultRule.searchItems;
    detailUrl = json['detailUrl'] ?? defaultRule.detailUrl;
    detailItems = json['detailItems'] ?? defaultRule.detailItems;
    enMultiRoads = json['enMultiRoads'] ?? defaultRule.enMultiRoads;
    chapterUrl = json['chapterUrl'] ?? defaultRule.chapterUrl;
    chapterItems = json['chapterItems'] ?? defaultRule.chapterItems;
    contentUrl = json['contentUrl'] ?? defaultRule.contentUrl;
    contentItems = json['contentItems'] ?? defaultRule.contentItems;
  }

  Rule.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        enable = json['enable'],
        name = json['name'],
        host = json['host'],
        contentType = json['contentType'],
        enCheerio = json['enCheerio'],
        discoverUrl = json['discoverUrl'],
        discoverItems = json['discoverItems'],
        searchUrl = json['searchUrl'],
        searchItems = json['searchItems'],
        detailUrl = json['detailUrl'],
        detailItems = json['detailItems'],
        enMultiRoads = json['enMultiRoads'],
        chapterUrl = json['chapterUrl'],
        chapterItems = json['chapterItems'],
        contentUrl = json['contentUrl'],
        contentItems = json['contentItems'];

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'enable': enable,
        'name': name,
        'host': host,
        'contentType': contentType,
        'enCheerio': enCheerio,
        'discoverUrl': discoverUrl,
        'discoverItems': discoverItems,
        'searchUrl': searchUrl,
        'searchItems': searchItems,
        'detailUrl': detailUrl,
        'detailItems': detailItems,
        'enMultiRoads': enMultiRoads,
        'chapterUrl': chapterUrl,
        'chapterItems': chapterItems,
        'contentUrl': contentUrl,
        'contentItems': contentItems,
      };
}
