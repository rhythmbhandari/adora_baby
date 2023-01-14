// To parse this JSON data, do
//
//     final getAddress = getAddressFromJson(jsonString);

import 'dart:convert';

GetAddress? getAddressFromJson(String str) => GetAddress.fromJson(json.decode(str));

String getAddressToJson(GetAddress? data) => json.encode(data!.toJson());

class GetAddress {
  GetAddress({
    this.next,
    this.previous,
    this.count,
    this.data,
  });

  dynamic next;
  dynamic previous;
  int? count;
  List<dynamic>? data;

  factory GetAddress.fromJson(Map<String, dynamic> json) => GetAddress(
    next: json["next"],
    previous: json["previous"],
    count: json["count"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "next": next,
    "previous": previous,
    "count": count,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
