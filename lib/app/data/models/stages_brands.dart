class Filters {
  Filters({
    required this.id,
    required this.name,
  });

  String id;
  String name;
  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
