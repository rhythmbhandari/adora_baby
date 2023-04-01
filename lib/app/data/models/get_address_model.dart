class AddressModel {
  AddressModel({
    required this.id,
    required this.city,
    required this.nearestLandmark,
    required this.addressType,
    required this.checked,
    required this.address,
  });

  String id;
  City city;
  String address;
  String nearestLandmark;
  String addressType;
  bool checked;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        city: City.fromJson(json["city"]),
        nearestLandmark: json["nearest_landmark"] ?? '',
        addressType: json["address_type"],
        address: json["address"] ?? '',
        checked: json["checked"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city.toJson(),
        "nearest_landmark": nearestLandmark,
        "address": address,
        "address_type": addressType,
        "checked": checked ?? false,
      };
}

class City {
  City({
    required this.id,
    required this.city,
  });

  String id;
  String city;


  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
      };
}
