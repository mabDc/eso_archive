import 'dart:convert';

import 'package:flutter/material.dart';
import 'search_page.dart';
import 'detail_page.dart';
import '../database/shelf_item.dart';
import '../database/rule.dart';
import '../global/global.dart';
import '../ui/show_error.dart';
import '../ui/custom_list_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShelfItem> shelfItems;
  List<Rule> rules;
  Future<bool> initFuture;

  Future<bool> init() async {
    shelfItems = await Global.shelfItemDao.findAllShelfItems();
    rules = await Global.ruleDao.findAllRules();
    return true;
  }

  Widget buildItem(ShelfItem shelfItem) {
    final item = jsonDecode(shelfItem.itemJson);
    final onTap = () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailPage(
              ruleID: shelfItem.ruleID,
              item: item,
            )));

    if (item["type"] == 'customListTile') {
      return Card(
          child: CustomListItem(
        itemJson: item,
        onTap: onTap,
      ));
    }
    return Card(
      child: ListTile(
        leading: item['thumbnailUrl'] == null
            ? Container()
            : Image.network('${item['thumbnailUrl']}'),
        title: Text(item['title']?.toString() ?? ''),
        subtitle: Text(
          item['subtitle']?.toString() ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(item['trailing']?.toString() ?? ''),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initFuture = init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eso'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SearchPage())),
          ),
        ],
      ),
      body: FutureBuilder(
        future: initFuture,
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
            itemCount: shelfItems.length,
            itemBuilder: (context, index) {
              return buildItem(shelfItems[index]);
            },
          );
        },
      ),
    );
  }
}
