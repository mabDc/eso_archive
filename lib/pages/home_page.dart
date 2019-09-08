import 'package:flutter/material.dart';
import 'search_page.dart';
import 'detail_page.dart';
import 'show_item.dart';
import '../database/shelf_item.dart';
import '../database/search_item.dart';
import '../global/global.dart';
import '../ui/show_error.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShelfItem> shelfItems;

  Future<bool> initItems() async {
    shelfItems = await Global.shelfItemDao.findAllShelfItems();
    return true;
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
        future: initItems(),
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
              ShelfItem shelfItem = shelfItems[index];
              SearchItem searchItem = SearchItem.fromShelfItem(shelfItem);
              return ShowItem(
                item: searchItem.item,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPage(
                            searchItem: searchItem,
                          )));
                },
                onLongPress: () async {
                  await Global.shelfItemDao.deleteShelfItem(shelfItem);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'deleted',
                    ),
                    action: SnackBarAction(
                      label: 'undo',
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () async {
                        await Global.shelfItemDao
                            .insertOrUpdateShelfItem(shelfItem);
                        setState(() {});
                      },
                    ),
                  ));
                  setState(() {});
                },
              );
            },
          );
        },
      ),
    );
  }
}
