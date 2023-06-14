import 'dart:convert';

List<ItemModel> itemModelFromJson(String str) => List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

String itemModelToJson(List<ItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemModel {
  String? id;
  String? title;
  String? desc;
  double? price;
  String? image;
  int? count;

  ItemModel({
    this.title,
    this.desc,
    this.price,
    this.image,
    this.count,
    this.id
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
    price: json["price"],
    image: json["image"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "desc": desc,
    "price": price,
    "image": image,
    "count": count,
  };
}
