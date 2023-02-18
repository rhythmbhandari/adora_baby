class Cities {
  Cities({
    required this.id,
    required this.city,
  });

  String id;
  String city;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        id: json["id"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
      };
}
