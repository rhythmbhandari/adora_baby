class OrderLogsModel {
  OrderLogsModel({
    required this.id,
    required this.orderId,
    required this.orderStatus,
    required this.updatedAt,
  });

  String id;
  String orderId;
  String orderStatus;
  DateTime updatedAt;

  factory OrderLogsModel.fromJson(Map<String, dynamic> json) => OrderLogsModel(
    id: json["id"],
    orderId: json["order_id"],
    orderStatus: json["order_status"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "order_status": orderStatus,
    "updated_at": updatedAt.toIso8601String(),
  };
}
