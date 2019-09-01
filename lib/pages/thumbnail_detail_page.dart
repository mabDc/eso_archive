import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import '../utils/rule.dart';
import '../ui/primary_color_text.dart';
import '../ui/custom_list_tile.dart';
import '../ui/show_error.dart';
import '../global/global.dart';
import '../utils/parser.dart';

class ThumbnailDetailPage extends StatefulWidget {
  ThumbnailDetailPage({
    @required this.rule,
    @required this.item,
    @required this.jsContext,
    Key key,
  }) : super(key: key);
  final Rule rule;
  final dynamic item;
  final JSContext jsContext;
  @override
  _ThumbnailDetailPageState createState() => _ThumbnailDetailPageState();
}

class _ThumbnailDetailPageState extends State<ThumbnailDetailPage> {
  final List<Widget> chapter = <Widget>[];
  final List<Widget> info = <Widget>[];
  String title = '';
  String url;
  bool notFirst = false;

  Future<bool> initPage() async {
    if (notFirst) {
      return true;
    } else {
      notFirst = true;
    }
    final jsContext = widget.jsContext;
    await jsContext.setProperty('item', widget.item);
    if (widget.rule.detailUrl != null && widget.rule.detailUrl.trim() != '') {
      final url = await jsContext.evaluateScript(widget.rule.detailUrl);
      await jsContext.setProperty('url', url);
      final response = await Parser().urlParser(url);
      await jsContext.setProperty('body', response.body);
    }
    dynamic detailItems =
        await jsContext.evaluateScript(widget.rule.detailItems);
    detailBuild(detailItems);

    if (widget.rule.chapterUrl != null && widget.rule.chapterUrl.trim() != '') {
      final url = await jsContext.evaluateScript(widget.rule.chapterUrl);
      await jsContext.setProperty('url', url);
      final response = await Parser().urlParser(url);
      await jsContext.setProperty('body', response.body);
    }
    dynamic chapterItems =
        await jsContext.evaluateScript(widget.rule.chapterItems);
    chapterBuild(chapterItems);
    return true;
  }

  void detailBuild(dynamic detailItems) {
    dynamic item = widget.item;
    title = '${item['title']}';
    if (item["type"] == 'customListTile') {
      info.add(CustomListItem(itemJson: item));
    } else {
      info.add(Card(
        child: ListTile(
          leading: Image.network('${item['thumbnailUrl']}'),
          title: Text('${item['title']}'),
          subtitle: Text(
            '${item['subtitle']}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text('${item['trailing']}'),
          isThreeLine: true,
        ),
      ));
    }

    if (detailItems is String) {
      detailItems = [detailItems];
    }
    detailItems.forEach((item) {
      if (item is String) {
        info.add(Card(
          child: ListTile(
            title: Text('$item'),
          ),
        ));
      } else if (item is Map) {
        dynamic type = item['type'];
        if (type == 'thumbnail') {
          dynamic thumbnailUrl = item["thumbnailUrl"];
          if (thumbnailUrl != null && thumbnailUrl != '') {
            info.add(Card(
              child: Image.network(thumbnailUrl),
            ));
          }
        } else {
          info.add(Card(
            child: ListTile(
              leading: item['thumbnailUrl'] == null
                  ? null
                  : Image.network(item['thumbnailUrl']),
              title: Text(item['title']?.toString() ?? ''),
              subtitle: Text(item['subtitle']?.toString() ?? ''),
              trailing: Text(item['trailing']?.toString() ?? ''),
            ),
          ));
        }
      }
    });
  }

  void chapterBuild(dynamic chapterItems) {
    if (widget.rule.enMultiRoads) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('enMultiRoads error'),
                ),
                body: ShowError(
                  errorMsg: 'enMultiRoads not yet in rule ${widget.rule.name}',
                ),
              )));
      return;
    }
    List items = chapterItems as List;
    chapter.add(ListTile(
      title: PrimaryColorText('chapter'),
      subtitle: PrimaryColorText('total ${items.length}'),
    ));
    items.forEach((item) {
      final onTap = () async {
        await widget.jsContext.setProperty('item', item);

        if (widget.rule.contentUrl != null &&
            widget.rule.contentUrl.trim() != '') {
          final url =
              await widget.jsContext.evaluateScript(widget.rule.contentUrl);
          await widget.jsContext.setProperty('url', url);
          final response = await Parser().urlParser(url);
          await widget.jsContext.setProperty('body', response.body);
        }
        dynamic detailItems =
            await widget.jsContext.evaluateScript(widget.rule.contentItems);
        List items = detailItems;
        return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          final body = ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Image.network(items[index]);
            },
          );
          return Global().setting.enFullScreen
              ? Scaffold(
                  body: body,
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Text(item['title']?.toString() ?? ''),
                  ),
                  body: body,
                );
        }));
      };
      chapter.add(Card(
          child: item["lock"] == null
              ? ListTile(
                  leading: item['leading'] == null
                      ? null
                      : Text(
                          item['leading']?.toString() ?? '',
                          textAlign: TextAlign.center,
                        ),
                  title: Text(item['title']?.toString() ?? ''),
                  subtitle: Text(item['subtitle']?.toString() ?? ''),
                  onTap: onTap,
                )
              : ListTile(
                  leading: item['leading'] == null
                      ? null
                      : Text(
                          item['leading']?.toString() ?? '',
                          textAlign: TextAlign.center,
                        ),
                  title: Text(item['title']?.toString() ?? ''),
                  subtitle: Text(item['subtitle']?.toString() ?? ''),
                  trailing: Icon(Icons.lock),
                  onTap: onTap,
                )));
    });
    chapter.add(Divider());
  }

  @override
  void initState() {
    title = widget.item['title']?.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<bool>(
          future: initPage(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ShowError(
                errorMsg: snapshot.error,
              );
            }
            if (!snapshot.hasData || !snapshot.data) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: info.length + chapter.length,
              itemBuilder: (context, index) {
                if (index < info.length) {
                  return info[index];
                } else {
                  return chapter[index - info.length];
                }
              },
            );
          }),
    );
  }
}
