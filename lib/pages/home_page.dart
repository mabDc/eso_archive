import 'package:flutter/material.dart';

import '../database/search_item.dart';
import '../database/shelf_item.dart';
import '../global/global.dart';
import 'detail_page.dart';
import 'search_page.dart';
import 'show_error.dart';
import 'show_item.dart';

class HomePage extends StatelessWidget {
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
      body: FutureBuilder<List<ShelfItem>>(
        future: Global.shelfItemDao.findAllShelfItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ShowError(
              errorMsg: snapshot.error,
            );
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          print('build');
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              ShelfItem shelfItem = snapshot.data[index];
              SearchItem searchItem = SearchItem.fromShelfItem(shelfItem);
              return ShowItem(
                item: searchItem.item,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPage(
                            searchItem: searchItem,
                          )));
                },
              );
            },
          );
        },
      ),
    );
  }
}
