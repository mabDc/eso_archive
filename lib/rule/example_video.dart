class ExampleVideo{
  Map<String, dynamic> get rule => {
        'enable':true,
        'name': 'example video',
        'host': 'http://www.zzzfun.com',
        'contentType': 'video',
        'enCheerio': true,
        'discoverUrl': '''
// you can use variable
// `\${host}` and `\${page}`
`\${host}/vod-type-id-1-page-\${page}.html`''',
        'discoverItems': '''
// you can use variable
// host as 'http://www.zzzfun.com'
// result as lastest rule executes result
// body as response.body
// because of enCheerio is true, also has `\$=cheerio.load(body)`

// type customListTile show as following
// thumbnailUrl;
// title;
// subtitle;
// author;
// publishDate;
// readDuration;

(()=>{
  var \$=cheerio.load(body);
  var list = [];
  \$('.search-result a').each((index,item) => {
    var type = 'customListTile';
    var href = `\${host}\${\$(item).attr('href')}`;
    var thumbnailUrl = \$('img',item).attr('src');
    var title = \$('.title-big',item).text();
    var subtitle = \$('.d-descr',item).text().replace(/\\s/g,'');
    var author = \$('.title-sub',item).text().replace(/\\s/g,'');
    var publishDate = '';
    var readDuration = '';
    list.push({type, href, thumbnailUrl, title, subtitle, author, publishDate, readDuration});
  });
  return list;
})();
/*
(()=>{
  var aa=cheerio.load(body);
  console.log(typeof(aa));
  console.log(aa);
  var xx = [];
  return aa('.search-result a').map((i,x)=>i.toString());
})();
*/
''', 
        'searchUrl': '''
// you can use variable 
// `\${host}` `\${keyword}` `\${page}`
`\${host}/vod-search-page-\${page}-wd-\${keyword}.html`''',
        'searchItems': '''
// here rule is like discoverItems
(()=>{
  var \$=cheerio.load(body);
  return \$('.show-list li').map((index,item) => {
    var type = 'customListTile';
    var href = `\${host}\${\$(item).attr('href')}`;
    var thumbnailUrl = \$('img',item).attr('src');
    var title = \$('h2',item).text();
    var subtitle = \$('.juqing',item).text();
    var author = \$('dl',item).first().text().replace(/\\s/g,'');
    var publishDate = '';
    var readDuration = '';
    return {type, href, thumbnailUrl, title, subtitle, author, publishDate, readDuration};
  });
})();''',
        'detailUrl': '//result is lastest rule executes result\nresult.href',
        'detailItems': '''
(()=>{
  var \$=cheerio.load(body);
  return \$('.count-item').text();
})();''',
        'enMultiRoads': true,
        'chapterUrl': '',
        'chapterItems': '''
(()=>{
  var \$=cheerio.load(body);
  var \$episode = \$('.episode');
  return \$('.slider-list').map((index,item){
    //default use listTile
    //var type = listTile;
    var title = \$(item).text();
    var a = \$('a', \$episode[index]);
    var subtitle = `共 \${\$a.length} 话`;
    var list = a.map((index,item){
      var title = \$(item).text();
      var href = \$(item).attr('href');
      return {title, href};
    });
    return {title, subtitle, list};
  });
})();''',
        'contentUrl': '''var m = result.href.match(/\\/vod-play-id-(\\d+)-sid-(\\d+)-nid-(\\d+)\\.html/);
var sid = m[2];
if(sid='1'){
  sid='';
}
`http://111.230.89.165:8089/zapi/play\${sid}.php?url=\${m[1]}-\${m[3]}`''',
        'contentItems': '',
      };
}