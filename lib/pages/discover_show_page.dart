import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';

import '../database/rule.dart';
import '../utils/parser.dart';
import 'show_items.dart';
import 'show_error.dart';
import '../global/global.dart';
import 'detail_page.dart';
import 'show_item.dart';
import '../database/search_item.dart';

class DiscoverShowPage extends StatefulWidget {
  DiscoverShowPage({
    @required this.rule,
    this.title,
    this.keyword,
    Key key,
  }) : super(key: key);

  final Rule rule;
  final String title;
  final String keyword;

  @override
  _DiscoverShowPageState createState() => _DiscoverShowPageState();
}

class _DiscoverShowPageState extends State<DiscoverShowPage> {
  JSContext jsContext;
  bool showSearchBar = false;

  @override
  void initState() {
    super.initState();
    jsContext = JSContext();
  }

  Future<bool> initJSContext() async {
    if (widget.rule.enCheerio) {
      String script =
          await DefaultAssetBundle.of(context).loadString(Global.cheerioFile);
      await jsContext.evaluateScript(script);
    }
    await jsContext.setProperty('host', widget.rule.host);
    await jsContext.setProperty('keyword', widget.keyword);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: showSearchBar
          ? ThemeData(primaryColor: Colors.white)
          : Theme.of(context),
      child: Scaffold(
        appBar: showSearchBar
            ? AppBar(
                title: TextField(
                  autofocus: true,
                  onSubmitted: (value) => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => DiscoverShowPage(
                              rule: widget.rule,
                              keyword: value.trim(),
                              title: 'search ${value.trim()}',
                            )),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        showSearchBar = false;
                      });
                    },
                  ),
                ],
              )
            : AppBar(
                title: Text(widget.title ?? 'discover - ${widget.rule.name}'),
                actions: widget.keyword == null
                    ? <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              showSearchBar = true;
                            });
                          },
                        ),
                      ]
                    : <Widget>[],
              ),
        body: FutureBuilder<bool>(
          future: initJSContext(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ShowError(
                errorMsg: snapshot.error,
              );
            }
            if (!snapshot.hasData || !snapshot.data) {
              return Center(child: CircularProgressIndicator());
            }
            return ShowItems(
              buildPage: (page) async {
                await jsContext.setProperty('page', page);
                dynamic url = await jsContext.evaluateScript(
                    widget.keyword == null
                        ? widget.rule.discoverUrl
                        : widget.rule.searchUrl);
                await jsContext.setProperty('url', url);
                final response = await Parser().urlParser(url);
                await jsContext.setProperty('body', response.body);
                return jsContext.evaluateScript(widget.keyword == null
                    ? widget.rule.discoverItems
                    : widget.rule.searchItems);
              },
              buildItem: (_item) {
                return ShowItem(
                  item: _item,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPage(
                      searchItem:
                          SearchItem(ruleID: widget.rule.id, item: _item, contentType: widget.rule.contentType),
                    ),
                  )),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (jsContext != null) {
      jsContext.cleanUp();
    }
    super.dispose();
  }
}
