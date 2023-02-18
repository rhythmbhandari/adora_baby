class CheckoutModel {
  CheckoutModel({
    required this.id,
    required this.cart,
    required this.fullName,
    required this.phoneNumber,
    required this.altPhoneNumber,
    required this.address,
    required this.specialNotes,
    required this.isDimondUse,
    required this.subTotal,
    required this.dimondOff,
    required this.discount,
    required this.deliveryCharge,
    required this.grandTotal,
    this.couponCode,
    required this.isCouponUse,
  });

  String id;
  List<String> cart;
  String fullName;
  String phoneNumber;
  String altPhoneNumber;
  String address;
  String specialNotes;
  bool isDimondUse;
  int subTotal;
  int dimondOff;
  int discount;
  int deliveryCharge;
  int grandTotal;
  dynamic couponCode;
  bool isCouponUse;

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
    id: json["id"],
    cart: List<String>.from(json["cart"].map((x) => x)),
    fullName: json["full_name"],
    phoneNumber: json["phone_number"],
    altPhoneNumber: json["alt_phone_number"],
    address: json["address"],
    specialNotes: json["special_notes"],
    isDimondUse: json["is_dimond_use"],
    subTotal: json["sub_total"],
    dimondOff: json["dimond_off"],
    discount: json["discount"],
    deliveryCharge: json["delivery_charge"],
    grandTotal: json["grand_total"],
    couponCode: json["coupon_code"],
    isCouponUse: json["is_coupon_use"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart": List<dynamic>.from(cart.map((x) => x)),
    "full_name": fullName,
    "phone_number": phoneNumber,
    "alt_phone_number": altPhoneNumber,
    "address": address,
    "special_notes": specialNotes,
    "is_dimond_use": isDimondUse,
    "sub_total": subTotal,
    "dimond_off": dimondOff,
    "discount": discount,
    "delivery_charge": deliveryCharge,
    "grand_total": grandTotal,
    "coupon_code": couponCode,
    "is_coupon_use": isCouponUse,
  };
}
