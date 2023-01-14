

class Datum {
  Datum({
    this.id,
    this.city,
    this.rate,
    this.estimatedTime,
  });

  String? id;
  String? city;
  int? rate;
  DateTime? estimatedTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    city: json["city"],
    rate: json["rate"],
    estimatedTime: DateTime.parse(json["estimated_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "rate": rate,
    "estimated_time": estimatedTime?.toIso8601String(),
  };
}
