class ThumbnailExample {
  Map<dynamic, dynamic> get rule => {
        'enable': true,
        'name': 'thumbnail example',
        'host': 'http://app.u17.com',
        'contentType': 'thumbnail',
        'enCheerio': false,
        'discoverUrl':
            '`\${host}/v3/appV3_3/android/phone/list/conditionScreenlists?page=\${page}`',
        'discoverItems': '''
(()=>{
  return JSON.parse(body).data
  .returnData.comics.map(comic=>{
    var type = 'customListTile';
    var url = `\${host}/v3/appV3_3/android/phone/comic/detail_static_new?&comicid=\${comic.comic_id}`;
    var thumbnailUrl = comic.cover;
    var title = comic.name;
    var subtitle = comic.description;
    var author = comic.author;
    var date = new Date(comic.lastUpdateTime*1000);
    var publishDate = `共\${comic.chapterCount}话 \${date.getFullYear()}年\${date.getMonth()+1}月\${date.getDate()}日`;
    var readDuration = comic.tags.join(' ');
    return {type, url, thumbnailUrl, title, subtitle, author, publishDate, readDuration};
  });
})();''',
        'searchUrl':
            '`\${host}/v3/appV3_3/android/phone/search/searchResult?q=\${keyword}&page=\${page}`',
        'searchItems': '''
(()=>{
  return JSON.parse(body).data
  .returnData.comics.map(comic=>{
    var type = 'customListTile';
    var url = `\${host}/v3/appV3_3/android/phone/comic/detail_static_new?&comicid=\${comic.comicId}`;
    var thumbnailUrl = comic.cover;
    var title = comic.name;
    var subtitle = comic.description;
    var author = comic.author;
    var publishDate = comic.passChapterNum;
    var readDuration = comic.tags.join(' ');
    return {type, url, thumbnailUrl, title, subtitle, author, publishDate, readDuration};
  });
})();''',
        'detailUrl': 'item.url',
        'detailItems': '''
(()=>{
  var returnData = JSON.parse(body).data.returnData;
  var comic = returnData.comic;
  var items = [];
  var date = new Date(comic.last_update_time*1000);
  items.push({
    title : comic.description,
    subtitle: `\\n\${comic.short_description}\\n\${comic.tagList.join(' ')} \${comic.theme_ids.join(' ')}\\n\${date.getFullYear()}年\${date.getMonth()+1}月\${date.getDate()}日`
  });
  items.push({
    type:'thumbnail',
    thumbnailUrl : comic.ori,
  });
  items.push({
    type:'thumbnail',
    thumbnailUrl : comic.wideCover,
  });
  var commentList = returnData.commentList;
  commentList.forEach(comment=>{
    items.push({
      type:'listTile',
      thumbnailUrl : comment.face,
      title : comment.nickname,
      subtitle: comment.create_time_str+' '+comment.ip
    });
    items.push(comment.content);
  });
  return items;
})();''',
        'enMultiRoads': false,
        'chapterUrl': '',
        'chapterItems': '''
(()=>{
  return JSON.parse(body).data
  .returnData.chapter_list.map((chapter,index)=>{
    var date = new Date(chapter.pass_time*1000);
    var title = chapter.name;
    var subtitle = `\${date.getFullYear()}年\${date.getMonth()+1}月\${date.getDate()}日`;
    var leading = `\${index+1}\\n·\\n\${chapter.image_total}P`;
    var lock = null;
    if(chapter.type == 2 || chapter.type == 3){
      lock = true;
    }
    var url = `\${host}/v3/appV3_3/android/phone/comic/chapterNew?chapter_id=\${chapter.chapter_id}`
    return {lock,title,subtitle,url,leading};
  });
})();''',
        'contentUrl': 'item.url',
        'contentItems': '''
(()=>{
  var returnData =  JSON.parse(body).data.returnData;
  var list = returnData.image_list||returnData.free_image_list;
  return list.map(images=>images.location);
})();''',
      };
}
