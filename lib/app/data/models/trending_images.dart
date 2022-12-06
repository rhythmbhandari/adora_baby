class TrendingImages {
  TrendingImages({
    required this.id,
    required this.name,
    required this.isActive,
  });

  String id;
  String name;
  bool isActive;

  factory TrendingImages.fromJson(Map<String, dynamic> json) => TrendingImages(
    id: json["id"],
    name: json["name"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_active": isActive,
  };
}
