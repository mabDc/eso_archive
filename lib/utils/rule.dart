class Rule {
  Rule();

  int id = DateTime.now().microsecondsSinceEpoch;
  bool enable = true;
  String name = 'rule templet';
  String host = '';
  String contentType = 'thumbnail';
  bool enCheerio = false;
  String discoverUrl = '''
// you can use variable as following
// host as 'http://www.zzzfun.com'
// page as current page
// url can be a string or map
// map should be {url, headers, method, body}
// headers is map, body can be string or map
// default headers is win10/Chrome User-Agent

`\${host}/vod-type-id-1-page-\${page}.html`''';
  String discoverItems = '''
// default type listTile show as following
// thumbnailUrl;
// title;
// subtitle;
// trailing
// {thumbnailUrl, title, subtitle, trailing}

// another type customListTile show as following
// thumbnailUrl;
// title;
// subtitle;
// author;
// publishDate;
// readDuration;

(() => {
  // templet 1, json
  var items = JSON.parse(body).items;
  var templet1 = items.data.map(item=>{
    var type = 'customListTile';
    // url is a custom varible
    var url = `\${host}/?id=\${item.id}`;
    var thumbnailUrl = item.cover;
    var title = item.name;
    var subtitle = item.description;
    var author = item.author;
    var publishDate = item.passChapterNum;
    var readDuration = item.tags.join(' ');
    return {type, url, thumbnailUrl, title, subtitle, author, publishDate, readDuration};
  });

  // templet 2, html with cheerio
  var templet2 = [];
  var \$=cheerio.load(body);
  \$('.search-result a').each((index,item) => {
    var type = 'customListTile';
    var url = `\${host}\${\$(item).attr('href')}`;
    var thumbnailUrl = \$('img',item).attr('src');
    var title = \$('.title-big',item).text();
    var subtitle = \$('.d-descr',item).text().replace(/\\s/g,'');
    var author = \$('.title-sub',item).text().replace(/\\s/g,'');
    var publishDate = '';
    var readDuration = '';
    templet2.push({type, url, thumbnailUrl, title, subtitle, author, publishDate, readDuration});
  });
  return templet2;
})();
''';
  String searchUrl = '// see discoverUrl';
  String searchItems = '// see discoverItems';
  String detailUrl = 'item.url';
  String detailItems = '''
// items can be string or List<item>
// item is string or map or map with type
// type can be thumbnail or default to listTile
// like {type:'thumbnail',thumbnailUrl : url}
// or {thumbnailUrl, title, subtitle, trailing}
(()=>{
  var items = [];

  return items;
})();
''';
  bool enMultiRoads = false;
  String chapterUrl = 'item.url';
  String chapterItems = '''
// default type listTile show as following
// it\'s diffirent to other rule
// leading;
// title;
// subtitle;
// lock 
(()=>{
  var items = [];

  return items;
})();
''';
  String contentUrl = 'item.url';
  String contentItems = '';

  Rule.safeFromJson(Map<dynamic, dynamic> json) {
    final defaultRule = Rule();
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
