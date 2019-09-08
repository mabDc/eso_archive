import 'shelf_item.dart';
import 'package:floor/floor.dart';

@dao
abstract class ShelfItemDao {
  @Query('SELECT * FROM shelfitem WHERE id = :id')
  Future<ShelfItem> findRuleById(int id);

  @Query('SELECT * FROM shelfitem')
  Future<List<ShelfItem>> findAllShelfItems();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertOrUpdateShelfItem(ShelfItem shelfItem);

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertOrUpdateShelfItems(List<ShelfItem> shelfItems);

  @delete
  Future<void> deleteShelfItem(ShelfItem shelfItem);

  @delete
  Future<void> deleteShelfItems(List<ShelfItem> shelfItems);
}