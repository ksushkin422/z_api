

import 'package:my_game/domain/model/item.dart';
import 'package:my_game/services/api_client.dart';

class ItemRepository {
  ApiClient _itemApiProvider = ApiClient();

  Future getItems()=> _itemApiProvider.apiGetMainItems();
}