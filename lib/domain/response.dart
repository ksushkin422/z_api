

import 'model/item.dart';

class ItemResponse {
  final List<Item> results;
  final String error;

  ItemResponse(this.results, this.error);

  ItemResponse.fromJson(List<dynamic> json):
        results = (json).map((e) => new Item.fromJson(e)).toList(),
        error = "";

  ItemResponse.withError(String errorValue):
        results = <Item>[],
        error = errorValue;

}