class AddressModel {
  AddressModel({
    required this.id,
    required this.city,
    required this.nearestLandmark,
    required this.createdBy,
    required this.addressType,
    required this.checked,
  });

  String id;
  City city;
  String nearestLandmark;
  String createdBy;
  String addressType;
  bool checked;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        city: City.fromJson(json["city"]),
        nearestLandmark: json["nearest_landmark"],
        createdBy: json["created_by"],
        addressType: json["address_type"],
        checked: json["checked"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city.toJson(),
        "nearest_landmark": nearestLandmark,
        "created_by": createdBy,
        "address_type": addressType,
        "checked": checked ?? false,
      };
}

class City {
  City({
    required this.id,
    required this.city,
    // required this.rate,
    required this.estimatedTime,
  });

  String id;
  String city;

  // int rate;
  DateTime estimatedTime;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        city: json["city"],
        // rate: json["rate"],
        estimatedTime: DateTime.parse(json["estimated_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        // "rate": rate,
        "estimated_time": estimatedTime.toIso8601String(),
      };
}
