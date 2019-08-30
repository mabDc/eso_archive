import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import '../utils/rule.dart';
import '../global/global.dart';
import 'package:http/http.dart' as http;
import '../ui/custom_list_tile.dart';
import '../utils/search_custom_item.dart';

class DiscoverShowPage extends StatefulWidget {
  DiscoverShowPage(
    this.rule, {
    Key key,
  }) : super(key: key);

  final Rule rule;

  @override
  _DiscoverShowPageState createState() => _DiscoverShowPageState();
}

class _DiscoverShowPageState extends State<DiscoverShowPage> {
  int page = 1;
  List<dynamic> items = <dynamic>[];
  JSContext jsContext;

  @override
  void initState() {
    jsContext = JSContext();
    super.initState();
  }

  Future<bool> discover() async {
    Rule rule = widget.rule;
    if (rule.enCheerio && page == 1) {
      String script =
          await DefaultAssetBundle.of(context).loadString(Global().cheerioFile);
      await jsContext.evaluateScript(script);
    }
    await jsContext.setProperty('host', rule.host);
    await jsContext.setProperty('page', page);
    dynamic url = await jsContext.evaluateScript(rule.discoverUrl);
    final response = await http.get(url?.toString() ?? '');
    await jsContext.setProperty('body', response.body);
    final _list = await jsContext.evaluateScript(rule.discoverItems);
    items.addAll(_list);
    page++;
    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final rule = widget.rule;
    return Scaffold(
        appBar: AppBar(
          title: Text('rule - ${rule.name}'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print('search'),
            ),
          ],
        ),
        body: FutureBuilder<bool>(
          future: discover(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData && snapshot.data
                ? ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      if (items.length - index == 1) {
                        discover();
                      }
                      final item = SearchCustomItem.safeFromJson(items[index]);
                      return CustomListTile(
                        thumbnail: Image.network(item.thumbnailUrl),
                        title: item.title,
                        subtitle: item.subtitle,
                        author: item.author,
                        publishDate: item.publishDate,
                        readDuration: item.readDuration,
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          },
        ));
  }

  @override
  void dispose() {
    if (jsContext != null) {
      jsContext.cleanUp();
    }
    super.dispose();
  }
}
