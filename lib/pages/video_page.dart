import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../utils/rule.dart';
import '../ui/primary_color_text.dart';
import '../ui/custom_list_tile.dart';
import '../utils/custom_item.dart';

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
    dynamic url = await jsContext.evaluateScript(widget.rule.detailUrl);
    if (url != null && url is String && url.trim() != '') {
      await jsContext.setProperty('url', url);
      final response = await http.get(url?.toString() ?? '');
      await jsContext.setProperty('body', response.body);
    }
    dynamic detailItems =
        await jsContext.evaluateScript(widget.rule.detailItems);
    detailBuild(detailItems);

    url = await jsContext.evaluateScript(widget.rule.chapterUrl);
    if (url != null && url is String && url.trim() != '') {
      await jsContext.setProperty('url', url);
      final response = await http.get(url?.toString() ?? '');
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
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
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
      ),
    );
  }

  void detailBuild(dynamic detailItems) {
    dynamic _item = widget.item;
    title = '${_item['title']}';
    if (_item["type"] == 'customListTile') {
      final item = CustomItem.safeFromJson(_item);
      info.add(CustomListTile(
        thumbnail: Image.network(item.thumbnailUrl),
        title: item.title,
        subtitle: item.subtitle,
        author: item.author,
        publishDate: item.publishDate,
        readDuration: item.readDuration,
      ));
    } else {
      info.add(Card(
        child: ListTile(
          leading: Image.network('${_item['thumbnailUrl']}'),
          title: Text('${_item['title']}'),
          subtitle: Text(
            '${_item['subtitle']}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text('${_item['trailing']}'),
          isThreeLine: true,
        ),
      ));
    }
    // info.add(Divider());

    if (detailItems is String) {
      detailItems = [detailItems];
    }
    detailItems.forEach((item) {
      info.add(Card(
        child: ListTile(
          title: Text('$item'),
        ),
      ));
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
