class Tips {
  Tips({
    required this.id,
    required this.shortDescription,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String shortDescription;
  String picture;
  DateTime createdAt;
  DateTime updatedAt;

  factory Tips.fromJson(Map<String, dynamic> json) => Tips(
    id: json["id"],
    shortDescription: json["short_description"],
    picture: json["picture"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "short_description": shortDescription,
    "picture": picture,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
