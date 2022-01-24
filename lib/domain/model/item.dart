import 'dart:convert';


List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));
List<Item> itemFromJsonList(List<dynamic> items) => List<Item>.from(items.map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  Item({
    required this.id,
    required this.title,
    required this.text,
    required this.kind,
    required this.completed,
    required this.dt,
  });

  final int id;
  final String title;
  final String text;
  final int kind;
  bool completed;
  final DateTime dt;


  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    text: json["text"],
    kind: json["kind"],
    completed: json["completed"],
    dt: DateTime.parse(json["dt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "text": text,
    "kind": kind,
    "completed": completed,
    "dt": dt.toIso8601String(),
  };

}