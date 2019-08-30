/*

import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import 'package:http/http.dart' as http;

import '../utils/rule.dart';
import '../utils/custom_item.dart';
import '../global/global.dart';
import 'custom_list_tile.dart';
import 'show_items.dart';
import 'show_error.dart';

class ShowPages extends StatelessWidget {
  ShowPages({
    this.rule,
    this.keyword,
    Key key,
  }) : super(key: key);

  final Rule rule;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    JSContext jsContext = JSContext();

    Future<bool> initJSContext() async {
      if (rule.enCheerio) {
        String script = await DefaultAssetBundle.of(context)
            .loadString(Global().cheerioFile);
        await jsContext.evaluateScript(script);
      }
      await jsContext.setProperty('host', rule.host);
      await jsContext.setProperty('keyword', keyword);
      return true;
    }

    return FutureBuilder<bool>(
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
                  keyword == null ? rule.discoverUrl : rule.searchUrl);
              await jsContext.setProperty('url', url);
              final response = await http.get(url?.toString() ?? '');
              await jsContext.setProperty('body', response.body);
              return jsContext.evaluateScript(
                  keyword == null ? rule.discoverItems : rule.searchItems);
            },
            buildItem: (_item) {
              if (_item["type"] == 'customListTile') {
                final item = CustomItem.safeFromJson(_item);
                return CustomListTile(
                  thumbnail: Image.network(item.thumbnailUrl),
                  title: item.title,
                  subtitle: item.subtitle,
                  author: item.author,
                  publishDate: item.publishDate,
                  readDuration: item.readDuration,
                  onTap: () {},
                );
              }
              dynamic item = _item;
              return ListTile(
                leading: Image.network('${item['thumbnailUrl']}'),
                title: Text('${item['title']}'),
                subtitle: Text(
                  '${item['subtitle']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text('${item['trailing']}'),
                isThreeLine: true,
              );
            },
          );
        });
  }
}

*/