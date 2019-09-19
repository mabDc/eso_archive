import 'package:floor/floor.dart';

@entity
class ShelfItem {
  @primaryKey
  int id;
  int ruleID;
  String contentType;
  String itemJson;

  ShelfItem(this.id, this.ruleID, this.contentType,this.itemJson);
}
