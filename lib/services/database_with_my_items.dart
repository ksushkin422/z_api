import 'package:my_game/domain/model/item.dart';
import '../db.dart';

class ItemsDBO {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createItem(Item item) async {
    final db = await dbProvider.database;
    var result = db!.insert(itemTable, item.toJson());
    return result;
  }

  Future<List<Item>> getItems({List<String>? columns, String? query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = [];
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db!.query(
          itemTable,
          columns: columns,
          // where: 'description LIKE ?',
          // whereArgs: ["%$query%"]
        );
      }
    } else {
      result = await db!.query(itemTable, columns: columns);
    }
    List<Item> items = result.isNotEmpty
        ? result.map((item) => Item.fromJson(item)).toList()
        : [];
    return items;
  }

  Future<int> updateItem(Item item) async {
    final db = await dbProvider.database;

    var result = await db!.update(itemTable, item.toJson(),
        where: "id = ?", whereArgs: [item.id]);

    return result;
  }

  Future<int> deleteItem(int id) async {
    final db = await dbProvider.database;
    var result = await db!.delete(itemTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}