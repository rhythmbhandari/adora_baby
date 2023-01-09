// To parse this JSON data, do
//
//     final allStages = allStagesFromJson(jsonString);

import 'dart:convert';
//
// AllStages allStagesFromJson(String str) => AllStages.fromJson(json.decode(str));
//
// String allStagesToJson(AllStages data) => json.encode(data.toJson());
//
// class AllStages {
//   AllStages({
//     this.next,
//     this.previous,
//     required this.count,
//     required this.data,
//   });
//
//   dynamic next;
//   dynamic previous;
//   int count;
//   List<Datum> data;
//
//   factory AllStages.fromJson(Map<String, dynamic> json) => AllStages(
//     next: json["next"],
//     previous: json["previous"],
//     count: json["count"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "next": next,
//     "previous": previous,
//     "count": count,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }

class Filters {
  Filters({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.isProductCategory,
  });

  String id;
  String name;
  String image;
  String description;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  bool isProductCategory;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isProductCategory: json["is_product_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "slug": slug,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_product_category": isProductCategory,
  };
}
