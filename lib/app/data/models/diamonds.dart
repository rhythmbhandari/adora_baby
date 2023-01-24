class Diamonds {
  Diamonds({
    required this.id,
    required this.amount,
    required this.orderId,
    required this.types,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  int amount;
  String orderId;
  String types;
  DateTime createdAt;
  DateTime updatedAt;

  factory Diamonds.fromJson(Map<String, dynamic> json) => Diamonds(
    id: json["id"],
    amount: json["amount"],
    orderId: json["orderId"],
    types: json["types"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "orderId": orderId,
    "types": types,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
