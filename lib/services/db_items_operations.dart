
import 'package:my_game/domain/model/item.dart';

import 'database_with_my_items.dart';

class ItemOperations {
  final itemDBO = ItemsDBO();

  Future getAllItems({String? query}) => itemDBO.getItems(query: query);

  Future insertItem(Item item) => itemDBO.createItem(item);

  Future updateItem(Item item) => itemDBO.updateItem(item);

  Future deleteItemById(int id) => itemDBO.deleteItem(id);

}
