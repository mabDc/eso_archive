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

class _CustomListItem extends StatelessWidget {
  _CustomListItem({
    Key key,
    this.thumbnailUrl,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final String thumbnailUrl;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnailUrl == null
                  ? Container()
                  : Image.network(thumbnailUrl),
            ),
            Expanded(
              child: _ArticleDescription(
                title: title,
                subtitle: subtitle,
                author: author,
                publishDate: publishDate,
                readDuration: readDuration,
              ),
            ),
          ],
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
}

class ShowItem extends StatelessWidget {
  ShowItem({
    this.item,
    this.onTap,
    this.onLongPress,
    Key key,
  }) : super(key: key);

  final dynamic item;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  Widget buildChild(dynamic item) {
    if (item["type"] == 'customListTile') {
      final _item = _CustomItem.safeFromJson(item);
      return _CustomListItem(
        thumbnailUrl: _item.thumbnailUrl,
        title: _item.title,
        subtitle: _item.subtitle,
        author: _item.author,
        publishDate: _item.publishDate,
        readDuration: _item.readDuration,
      );
    } else {
      return ListTile(
        leading: item['thumbnailUrl'] == null
            ? Container()
            : Image.network('${item['thumbnailUrl']}'),
        title: Text(item['title']?.toString() ?? ''),
        subtitle: Text(
          item['subtitle']?.toString() ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(item['trailing']?.toString() ?? ''),
        isThreeLine: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        child: buildChild(item),
      ),
    );
  }
}
