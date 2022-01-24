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
  }

  // newItem(Item) async {
  //   var response = await itemData
  // }

  dispose() {
    _items.close();
  }

  BehaviorSubject<ItemResponse> get items => _items;

}

final bloc = ItemBloc();