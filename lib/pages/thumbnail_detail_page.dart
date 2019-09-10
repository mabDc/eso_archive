import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import '../database/rule.dart';
import 'show_error.dart';
import '../global/global.dart';
import '../utils/parser.dart';
import 'show_item.dart';
import '../database/search_item.dart';

class ThumbnailDetailPage extends StatefulWidget {
  ThumbnailDetailPage({
    @required this.searchItem,
    Key key,
  }) : super(key: key);

  final SearchItem searchItem;
  @override
  _ThumbnailDetailPageState createState() => _ThumbnailDetailPageState();
}

class _ThumbnailDetailPageState extends State<ThumbnailDetailPage> {
  final List<Widget> chapter = <Widget>[];
  final List<Widget> info = <Widget>[];
  String title = '';
  String url;
  Future<bool> initFuture;
  JSContext jsContext;
  Rule rule;
  bool isInShelf;

  @override
  void initState() {
    super.initState();
    title = widget.searchItem.item['title']?.toString() ?? '';
    jsContext = JSContext();
    initFuture = init();
  }

  Future<bool> init() async {
    rule = await Global.ruleDao.findRuleById(widget.searchItem.ruleID);
    final shelfItem = await Global.shelfItemDao
        .findShelfItemById(widget.searchItem.shelfItem.id);
    isInShelf = shelfItem != null;
    if (rule.enCheerio) {
      String script =
          await DefaultAssetBundle.of(context).loadString(Global.cheerioFile);
      await jsContext.evaluateScript(script);
    }
    await jsContext.setProperty('host', rule.host);
    await jsContext.setProperty('item', widget.searchItem.item);
    if (rule.detailUrl != null && rule.detailUrl.trim() != '') {
      final url = await jsContext.evaluateScript(rule.detailUrl);
      await jsContext.setProperty('url', url);
      final response = await Parser().urlParser(url);
      await jsContext.setProperty('body', response.body);
    }
    dynamic detailItems = await jsContext.evaluateScript(rule.detailItems);
    detailBuild(detailItems);

    if (rule.chapterUrl != null && rule.chapterUrl.trim() != '') {
      final url = await jsContext.evaluateScript(rule.chapterUrl);
      await jsContext.setProperty('url', url);
      final response = await Parser().urlParser(url);
      await jsContext.setProperty('body', response.body);
    }
    dynamic chapterItems = await jsContext.evaluateScript(rule.chapterItems);
    chapterBuild(chapterItems);
    return true;
  }

  void detailBuild(dynamic detailItems) {
    info.add(ShowItem(item: widget.searchItem.item));

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
    if (rule.enMultiRoads) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('enMultiRoads error'),
                ),
                body: ShowError(
                  errorMsg: 'enMultiRoads not yet in rule ${rule.name}',
                ),
              )));
      return;
    }
    List items = chapterItems as List;
    chapter.add(ListTile(
      title: Text(
        'chapter',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      subtitle: Text(
        'total ${items.length}',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    ));
    items.forEach((item) {
      final onTap = () async {
        await jsContext.setProperty('item', item);
        if (rule.contentUrl != null && rule.contentUrl.trim() != '') {
          final url = await jsContext.evaluateScript(rule.contentUrl);
          await jsContext.setProperty('url', url);
          final response = await Parser().urlParser(url);
          await jsContext.setProperty('body', response.body);
        }
        dynamic detailItems = await jsContext.evaluateScript(rule.contentItems);
        List items = detailItems;
        return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          final body = ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return FadeInImage.assetNetwork(placeholder: 'lib/assets/waiting.png',image: items[index],);
            },
          );
          return Global.profile.enFullScreen
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
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: initFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ShowError(
            errorMsg: snapshot.error,
          );
        }
        if (!snapshot.hasData || !snapshot.data) {
          return Scaffold(body: Center(child: CircularProgressIndicator()),);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          floatingActionButton: FloatingActionButton(
            child:
                isInShelf ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            tooltip: 'add to shelf',
            onPressed: () async {
              if (isInShelf) {
                await Global.shelfItemDao
                    .deleteShelfItem(widget.searchItem.shelfItem);
              } else {
                await Global.shelfItemDao
                    .insertOrUpdateShelfItem(widget.searchItem.shelfItem);
              }
              setState(() {
                isInShelf = !isInShelf;
              });
            },
          ),
          body: ListView.builder(
            itemCount: info.length + chapter.length,
            itemBuilder: (context, index) {
              if (index < info.length) {
                return info[index];
              } else {
                return chapter[index - info.length];
              }
            },
          ),
        );
      },
    );
  }
}
