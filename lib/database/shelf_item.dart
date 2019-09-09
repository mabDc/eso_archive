import 'package:floor/floor.dart';

@entity
class ShelfItem {
  @primaryKey
  int id;
  int ruleID;
  String contentType;
  String itemJson;

  ShelfItem(this.id, this.ruleID, this.contentType,this.itemJson);

  // ShelfItem.newItem(this.ruleID, dynamic item) {
  //   id = DateTime.now().microsecondsSinceEpoch;
  //   itemJson = jsonEncode(item);
  // }

  // set item (Map map) {
  //   itemJson = jsonEncode(map);
  // }
  // Map get item => jsonDecode(itemJson);
}
