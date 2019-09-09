import 'dart:convert';
import 'shelf_item.dart';
import 'package:flutter/material.dart';

class SearchItem {
  int id;
  int ruleID;
  String contentType;
  Map item;

  SearchItem({
    this.id,
    @required this.ruleID,
    @required this.contentType,
    @required this.item,
  });

  ShelfItem get shelfItem => ShelfItem(
        item.toString().hashCode,
        ruleID,
        contentType,
        jsonEncode(item),
      );

  SearchItem.fromShelfItem(ShelfItem shelfItem) {
    id = shelfItem.id;
    ruleID = shelfItem.ruleID;
    contentType = shelfItem.contentType;
    item = jsonDecode(shelfItem.itemJson);
  }
}
