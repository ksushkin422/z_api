import 'package:my_game/domain/response.dart';
import 'package:my_game/services/api_client.dart';
import 'package:rxdart/rxdart.dart';

class ItemBloc {
  final ApiClient itemData = ApiClient();
  final BehaviorSubject<ItemResponse> _items = BehaviorSubject<ItemResponse>();

  getItems() async {
    var response = await itemData.apiGetMainItems();
    _items.sink.add(response);
  }

  deleteItem(int id) async {
    await itemData.apiDeleteItem(id);
    getItems();
  }

  newItem(Map req_json) async {
    await itemData.apiSetNewItem(req_json);
    getItems();
  }

  dispose() {
    _items.close();
  }

  BehaviorSubject<ItemResponse> get items => _items;

}

final bloc = ItemBloc();