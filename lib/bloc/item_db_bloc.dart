
import 'dart:async';

import 'package:my_game/domain/model/item.dart';
import 'package:my_game/services/db_items_operations.dart';

class ItemBloc{
  final _item = ItemOperations();
  final _itemController = StreamController<List<Item>>.broadcast();

  get items => _itemController.stream;

  ItemBloc() {
    getItems();
  }

  getItems({String? query}) async {
    _itemController.sink.add(await _item.getAllItems(query: query));
  }

  addItem(Item item) async {
    await _item.insertItem(item);
    getItems();
  }

  updateItem(Item item) async {
    await _item.updateItem(item);
    getItems();
  }

  deleteItem(int id) async {
    _item.deleteItemById(id);
    getItems();
  }

  dispose() {
    _itemController.close();
  }
}