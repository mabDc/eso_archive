class ExampleVideo {
  Map<String, dynamic> get rule => {
        'enable': true,
        'name': 'video example',
        'host': 'http://www.zzzfun.com',
        'contentType': 'video',
        'enCheerio': true,
        'discoverUrl': '''
// you can use variable as following
// host as 'http://www.zzzfun.com'
// page as current page
`\${host}/vod-type-id-1-page-\${page}.html`''',
        'discoverItems': '''
// you can use variable as following
// host as 'http://www.zzzfun.com'
// page as current page
// url as lastest urlRule executes result
// body as response.body
// because of enCheerio is true, 
// you can use `\$=cheerio.load(body)`

// type customListTile show as following
// thumbnailUrl;
// title;
// subtitle;
// author;
// publishDate;
// readDuration;

(()=>{
  var \$=cheerio.load(body);
  var items = [];
  \$('.search-result a').each((index,item) => {
    var type = 'customListTile';
    var href = `\${host}\${\$(item).attr('href')}`;
    var thumbnailUrl = \$('img',item).attr('src');
    var title = \$('.title-big',item).text();
    var subtitle = \$('.d-descr',item).text().replace(/\\s/g,'');
    var author = \$('.title-sub',item).text().replace(/\\s/g,'');
    var publishDate = 'zzzfun';
    var readDuration = '';
    items.push({type, href, thumbnailUrl, title, subtitle, author, publishDate, readDuration});
  });
  return items;
})();''',
        'searchUrl': '''
// you can use variable as following
// host as 'http://www.zzzfun.com'
// page as current page
// keyword as search key
`\${host}/vod-search-page-\${page}-wd-\${keyword}.html`''',
        'searchItems': '''
// here rule is like discoverItems
(()=>{
  var \$=cheerio.load(body);
  var items = [];
  \$('.show-list li').each((index,item) => {
    var type = 'customListTile';
    var href = `\${host}\${\$('h2 a',item).attr('href')}`;
    var thumbnailUrl = \$('img',item).attr('src');
    var title = \$('h2 a',item).text();
    var subtitle = \$('.juqing',item).text();
    var author = \$('dl',item).first().text().replace(/\\s/g,'');
    var publishDate = 'zzzfun';
    var readDuration = '';
    items.push({type, href, thumbnailUrl, title, subtitle, author, publishDate, readDuration});
  });
  return items;
})();''',
        'detailUrl': '//item is lastest item rule executes result\nitem.href',
        'detailItems': '''
// because of holding on jscontext
// you can use any used variables
// like host page keyword url item and so on
(()=>{
  var \$=cheerio.load(body);
  var s = [];
  \$('.count-item').each((index,item) => {
    s.push(\$(item).text().replace(/\\s/g,''));
  });
  var info = \$('.content-row').text().replace(/\\s/g,'');
  var bieming = \$('.btm-text').text().replace(/\\s/g,'');
  return [s.join('\\n'),info,bieming];

})();''',
        'enMultiRoads': true,
        'chapterUrl': '',
        'chapterItems': '''
(()=>{
  var \$=cheerio.load(body);
  var \$episode = \$('.episode');
  var roads = [];
  \$('.slider-list').each((index,slider)=>{
    // default use listTile, props show as following
    // leading;
    // title;
    // subtitle;
    // lock;
    // you should use chapter as list name

    var title = \$(slider).text().trim();
    var a = \$('a', \$episode[index]);
    var subtitle = `共 \${a.length} 话`;
    var chapter = [];
    a.each((index,item)=>{
      var title = \$(item).text();
      var subtitle = \$(item).attr('href');
      var href = \$(item).attr('href');
      chapter.push({title, subtitle});
    });
    roads.push({title, subtitle,chapter});
  });
  return roads;
})();''',
        'contentUrl': '''
(()=>{
  var m = item.subtitle.match(/\\/vod-play-id-(\\d+)-sid-(\\d+)-nid-(\\d+)\\.html/);
  var sid = m[2];
  if(sid='1'){
    sid='';
  }
  return `http://111.230.89.165:8089/zapi/play\${sid}.php?url=\${m[1]}-\${m[3]}`;
})();''',
        'contentItems': '',
      };
}
