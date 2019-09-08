import 'dart:convert';
import 'shelf_item.dart';

class SearchItem {
  int id;
  int ruleID;
  Map item;

  SearchItem({
    this.id,
    this.ruleID,
    this.item,
  });

  ShelfItem get shelfItem => ShelfItem(
        id ?? DateTime.now().microsecondsSinceEpoch,
        ruleID,
        jsonEncode(item),
      );

  SearchItem.fromShelfItem(ShelfItem shelfItem) {
    id = shelfItem.id;
    ruleID = shelfItem.ruleID;
    item = jsonDecode(shelfItem.itemJson);
  }
}
