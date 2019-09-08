import 'package:flutter/material.dart';

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.0,
                  color:
                      Theme.of(context).textTheme.body1.color.withOpacity(0.54),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$author',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.0,
                  color:
                      Theme.of(context).textTheme.body1.color.withOpacity(0.87),
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.0,
                  color:
                      Theme.of(context).textTheme.body1.color.withOpacity(0.54),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItem extends StatelessWidget {
  CustomListItem({
    Key key,
    // this.thumbnail,
    // this.title,
    // this.subtitle,
    // this.author,
    // this.publishDate,
    // this.readDuration,
    this.onTap,
    this.itemJson,
  }) : super(key: key);

  // final Widget thumbnail;
  // final String title;
  // final String subtitle;
  // final String author;
  // final String publishDate;
  // final String readDuration;
  final dynamic itemJson;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final item = _CustomItem.safeFromJson(itemJson ?? Map());
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,10.0,10.0,10.0),
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: item.thumbnailUrl == null
                    ? Container()
                    : Image.network(item.thumbnailUrl),
              ),
              Expanded(
                child: _ArticleDescription(
                    title: item.title,
                    subtitle: item.subtitle,
                    author: item.author,
                    publishDate: item.publishDate,
                    readDuration: item.readDuration,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomItem {
  final String thumbnailUrl;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  _CustomItem.safeFromJson(Map json)
      : thumbnailUrl = json['thumbnailUrl']?.toString() ?? '',
        title = json['title']?.toString() ?? '',
        subtitle = json['subtitle']?.toString() ?? '',
        author = json['author']?.toString() ?? '',
        publishDate = json['publishDate']?.toString() ?? '',
        readDuration = json['readDuration']?.toString() ?? '';

  // CustomItem({
  //   this.thumbnailUrl,
  //   this.title,
  //   this.subtitle,
  //   this.author,
  //   this.publishDate,
  //   this.readDuration,
  // });

  // CustomItem.fromJson(Map<dynamic, dynamic> json)
  //     : thumbnailUrl = json['thumbnailUrl'],
  //       title = json['title'],
  //       subtitle = json['subtitle'],
  //       author = json['author'],
  //       publishDate = json['publishDate'],
  //       readDuration = json['readDuration'];

  // Map<dynamic, dynamic> toJson() => {
  //       'thumbnailUrl': thumbnailUrl,
  //       'title': title,
  //       'subtitle': subtitle,
  //       'author': author,
  //       'publishDate': publishDate,
  //       'readDuration': readDuration,
  //     };
}
