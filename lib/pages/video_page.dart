import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../database/rule.dart';
import '../database/search_item.dart';
import '../global/global.dart';
import '../utils/parser.dart';
import 'show_item.dart';
import 'show_error.dart';

class VideoPage extends StatefulWidget {
  VideoPage({
    @required this.searchItem,
    Key key,
  }) : super(key: key);

  final SearchItem searchItem;
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  VideoPlayerController videoPlayerController;
  TabController tabcontroller;
  JSContext jsContext;
  Future<bool> initFuture;

  List<Widget> chapter = <Widget>[];
  List<Widget> info = <Widget>[];
  String title;
  String url;
  String ruleContentURL;
  bool enMultiRoads;
  bool isInShelf;

  @override
  void initState() {
    super.initState();
    title = widget.searchItem.item['title']?.toString() ?? '';
    initFuture = init();
    jsContext = JSContext();
    tabcontroller = TabController(length: 2, vsync: this);
  }

  Future<bool> init() async {
    Rule rule = await Global.ruleDao.findRuleById(widget.searchItem.ruleID);
    final shelfItem = await Global.shelfItemDao
        .findShelfItemById(widget.searchItem.shelfItem.id);
    isInShelf = shelfItem != null;
    enMultiRoads = rule.enMultiRoads;
    ruleContentURL = rule.contentUrl;
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

  Widget buildBody(){
    return Column(
      children: <Widget>[
        url == null
            ? Container(
                height: 220,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              )
            : Chewie(
                controller: ChewieController(
                videoPlayerController: videoPlayerController,
                aspectRatio: 16 / 9,
                autoPlay: true,
              )),
        Material(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            controller: tabcontroller,
            indicatorColor: Theme.of(context).primaryTextTheme.title.color,
            labelColor: Theme.of(context).primaryTextTheme.title.color,
            unselectedLabelColor: Theme.of(context)
                .primaryTextTheme
                .title
                .color
                .withOpacity(0.75),
            tabs: <Tab>[
              Tab(text: 'list'),
              Tab(text: 'desc'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(controller: tabcontroller, children: <Widget>[
            ListView.builder(
              itemCount: chapter.length,
              itemBuilder: (context, index) => chapter[index],
            ),
            ListView.builder(
              itemCount: info.length,
              itemBuilder: (context, index) => info[index],
            ),
          ]),
        ),
      ],
    );
  }

  Widget buildFloatingButton(){
    return FloatingActionButton(
      child: isInShelf
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border),
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
    );
  }
  @override
  Widget build(BuildContext context) {
    if (url != null) {
      if (videoPlayerController == null) {
        videoPlayerController = VideoPlayerController.network(url);
      } else if (videoPlayerController.dataSource != url) {
        videoPlayerController.dispose();
        videoPlayerController = VideoPlayerController.network(url);
      }
    }
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
          return Global.profile.enFullScreen
              ? Scaffold(
                  body: buildBody() ,
                  floatingActionButton: buildFloatingButton(),
                )
              : Scaffold(
                  appBar: AppBar(title: Text(title)),
                  body: buildBody(),
                  floatingActionButton: buildFloatingButton(),
                );
        });
  }

  void detailBuild(dynamic detailItems) {
    info.add(ShowItem(item: widget.searchItem.item));

    if (detailItems is String) {
      detailItems = [detailItems];
    }
    detailItems.forEach((item) {
      if (item is String || item is num) {
        info.add(Card(
          child: ListTile(
            title: Text('$item'),
          ),
        ));
      } else if (item is Map) {
        dynamic type = item['type'] ?? item['风格'];
        if (type == 'thumbnail' || type == '图片') {
          dynamic thumbnailUrl = item["thumbnailUrl"] ?? item["地址"];
          if (thumbnailUrl != null && thumbnailUrl != '') {
            info.add(Card(
              child: Image.network(thumbnailUrl),
            ));
          }
        } else {
          info.add(Card(
            child: ListTile(
              leading: item['thumbnailUrl'] == null && item['封面'] == null
                  ? null
                  : Image.network(item['thumbnailUrl'] ?? item['封面']),
              title: Text(
                  item['title']?.toString() ?? item['标题']?.toString() ?? ''),
              subtitle: Text(item['subtitle']?.toString() ??
                  item['副标题']?.toString() ??
                  ''),
              trailing: Text(
                  item['trailing']?.toString() ?? item['后缀']?.toString() ?? ''),
            ),
          ));
        }
      }
    });
  }

  void chapterBuild(dynamic chapterItems) {
    List roads;
    if (enMultiRoads == true) {
      roads = chapterItems;
    } else {
      roads = [chapterItems];
    }
    roads.forEach((road) {
      chapter.add(ListTile(
        leading: road['leading'] == null
            ? null
            : Text(
                road['leading']?.toString() ?? '',
                textAlign: TextAlign.center,
              ),
        title: Text(
          road['title']?.toString() ?? '',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        subtitle: Text(
          road['subtitle']?.toString() ?? '',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        trailing: Text(
          road['trailing']?.toString() ?? '',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ));
      (road['chapter'] as List).forEach((item) {
        chapter.add(Card(
          child: ListTile(
            leading: item['leading'] == null
                ? null
                : Text(
                    item['leading']?.toString() ?? '',
                    textAlign: TextAlign.center,
                  ),
            title: Text(item['title']?.toString() ?? ''),
            subtitle: Text(item['subtitle']?.toString() ?? ''),
            trailing: Text(item['trailing']?.toString() ?? ''),
            onTap: () async {
              await jsContext.setProperty('item', item);
              dynamic contentUrl =
                  await jsContext.evaluateScript(ruleContentURL);
              setState(() {
                title = item['title']?.toString() ?? '';
                url = contentUrl;
              });
            },
          ),
        ));
      });
      chapter.add(Divider());
    });
  }

  @override
  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController.dispose();
    }
    if (jsContext != null) {
      jsContext.cleanUp();
    }
    tabcontroller.dispose();
    super.dispose();
  }
}
