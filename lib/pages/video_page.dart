import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../database/rule.dart';
import '../ui/primary_color_text.dart';
import '../global/global.dart';
import '../utils/parser.dart';
import 'show_item.dart';

class VideoPage extends StatefulWidget {
  VideoPage({
    @required this.rule,
    @required this.item,
    @required this.jsContext,
    Key key,
  }) : super(key: key);

  final Rule rule;
  final dynamic item;
  final JSContext jsContext;
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  VideoPlayerController videoPlayerController;
  TabController tabcontroller;
  final List<Widget> chapter = <Widget>[];
  final List<Widget> info = <Widget>[];
  String title = '';
  String url;
  bool notFirst = false;

  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 2, vsync: this);
  }

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
    setState(() {});
    return true;
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
    initPage();
    final body = Column(
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
    return Global.profile.enFullScreen
        ? Scaffold(
            body: body,
          )
        : Scaffold(
            appBar: AppBar(title: Text(title)),
            body: body,
          );
  }

  void detailBuild(dynamic detailItems) {
    title = '${widget.item['title']}';
    info.add(ShowItem(item: widget.item));
    
    // dynamic item = widget.item;
    // title = '${item['title']}';
    // if (item["type"] == 'customListTile') {
    //   info.add(CustomListItem(itemJson: item));
    // } else {
    //   info.add(Card(
    //     child: ListTile(
    //       leading: Image.network('${item['thumbnailUrl']}'),
    //       title: Text('${item['title']}'),
    //       subtitle: Text(
    //         '${item['subtitle']}',
    //         maxLines: 2,
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //       trailing: Text('${item['trailing']}'),
    //       isThreeLine: true,
    //     ),
    //   ));
    // }
    // info.add(Divider());

    // if (detailItems is String) {
    //   detailItems = [detailItems];
    // }
    // detailItems.forEach((item) {
    //   info.add(Card(
    //     child: ListTile(
    //       title: Text('$item'),
    //     ),
    //   ));
    // });

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
    List roads;
    if (widget.rule.enMultiRoads == true) {
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
        title: PrimaryColorText(road['title']?.toString() ?? ''),
        subtitle: PrimaryColorText(road['subtitle']?.toString() ?? ''),
        trailing: PrimaryColorText(road['trailing']?.toString() ?? ''),
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
              await widget.jsContext.setProperty('item', item);
              dynamic contentUrl =
                  await widget.jsContext.evaluateScript(widget.rule.contentUrl);
              setState(() {
                title = '${item['title']}';
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
    tabcontroller.dispose();
    super.dispose();
  }
}
