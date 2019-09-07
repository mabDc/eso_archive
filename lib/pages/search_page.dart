import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:flutter/material.dart';
import '../utils/rule.dart';
import '../rule/thumbnail_example.dart';
import '../rule/video_example.dart';
import '../global/global.dart';
import '../utils/parser.dart';
import '../ui/show_error.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<dynamic> items = <dynamic>[];
  List<Rule> rules = <Rule>[];
  int nextPage = 0;
  List<JSContext> jsContextArray = <JSContext>[];
  Future<bool> initJSContextFuture;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    initJSContextFuture = initJSContext();
  }

  Future<bool> initJSContext() async {
    // 数据库获取所有图源形成数组
    rules = [
      Rule.safeFromJson(VideoExample().rule),
      Rule.safeFromJson(ThumbnailExample().rule)
    ];
    String script =
        await DefaultAssetBundle.of(context).loadString(Global.cheerioFile);
    for (var rule in rules) {
      JSContext jsContext = JSContext();
      await jsContext.setProperty('host', rule.host);
      if (rule.enCheerio) {
        await jsContext.evaluateScript(script);
      }
      jsContextArray.add(jsContext);
    }
    return true;
  }

  Future search() async {
    setState(() {
      items.clear();
    });
    String key = textController.text.trim();
    for (var jsContext in jsContextArray) {
      await jsContext.setProperty('keyword', key);
    }
    loadMore();
  }

  Future loadMore() async {
    nextPage++;
    for (var i = 0; i < rules.length; i++) {
      (() async {
        Rule rule = rules[i];
        JSContext jsContext = jsContextArray[i];
        await jsContext.setProperty('page', nextPage);
        dynamic url = await jsContext.evaluateScript(rule.searchUrl);
        await jsContext.setProperty('url', url);
        final response = await Parser().urlParser(url);
        await jsContext.setProperty('body', response.body);
        List _items = await jsContext.evaluateScript(rule.searchItems);
        setState(() {
          items.addAll(_items);
        });
      })();
    }
  }

  Widget buildItem(dynamic item) {
    return Card(
      child: ListTile(
        title: Text(item.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: ThemeData(primaryColor: Colors.white).textTheme,
        title: TextField(
          controller: textController,
          onSubmitted: (text) {
            search();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: search,
          )
        ],
      ),
      body: FutureBuilder(
        future: initJSContextFuture,
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
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == items.length) {
                if (index == 0) {
                  return Container();
                }
                return Center(child: CircularProgressIndicator());
              } else {
                final item = items[index];
                return buildItem(item);
              }
            },
            controller: scrollController,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();
    jsContextArray.forEach((jSContext) {
      jSContext.cleanUp();
    });
    super.dispose();
  }
}
