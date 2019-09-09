import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:flutter/material.dart';
import '../database/rule.dart';
import '../global/global.dart';
import '../utils/parser.dart';
import 'show_error.dart';
import 'detail_page.dart';
import 'show_item.dart';
import '../database/search_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<SearchItem> searchItems = <SearchItem>[];
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
    // get sources from database
    rules = await Global.ruleDao.findAllRules();
    // filter source with enable
    rules = rules.where((rule) => rule.enable).toList();
    if (rules.length == 0) return false;

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
      searchItems.clear();
      nextPage = 0;
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
      ((int i) async {
        Rule rule = rules[i];
        JSContext jsContext = jsContextArray[i];
        await jsContext.setProperty('page', nextPage);
        dynamic url = await jsContext.evaluateScript(rule.searchUrl);
        if (url == null) return;
        await jsContext.setProperty('url', url);
        final response = await Parser().urlParser(url);
        await jsContext.setProperty('body', response.body);
        List items = await jsContext.evaluateScript(rule.searchItems);
        setState(() {
          searchItems.addAll(
              items.map((item) => SearchItem(ruleID: rule.id, item: item, contentType: rule.contentType)));
        });
      })(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initJSContextFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ShowError(
            errorMsg: snapshot.error,
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.data) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                'none enable source',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
        }

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
          body: ListView.builder(
            controller: scrollController,
            itemCount: searchItems.length + 1,
            itemBuilder: (context, index) {
              if (index == searchItems.length) {
                if (index == 0) {
                  return Container();
                }
                return Center(child: CircularProgressIndicator());
              } else {
                SearchItem searchItem = searchItems[index];
                return ShowItem(
                  item: searchItem.item,
                  onTap: () async {
                    // await Global.shelfItemDao
                    //     .insertOrUpdateShelfItem(searchItem.shelfItem);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(
                              searchItem: searchItem,
                            )));
                  },
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();

    jsContextArray.forEach((jsContext) {
      if(jsContext != null){
        jsContext.cleanUp();
      }
    });

    super.dispose();
  }
}