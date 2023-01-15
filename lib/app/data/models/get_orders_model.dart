

class Datum {
  Datum({
    this.id,
    this.checkOut,
    this.trackingCode,
    this.estimatedTime,
    this.status,
    this.updatedAt,
  });

  String? id;
  CheckOut? checkOut;
  String? trackingCode;
  DateTime? estimatedTime;
  String? status;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    checkOut: CheckOut.fromJson(json["check_out"]),
    trackingCode: json["tracking_code"],
    estimatedTime: DateTime.parse(json["estimated_time"]),
    status: json["status"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "check_out": checkOut!.toJson(),
    "tracking_code": trackingCode,
    "estimated_time": estimatedTime?.toIso8601String(),
    "status": status,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class CheckOut {
  CheckOut({
    this.id,
    this.cart,
    this.fullName,
    this.phoneNumber,
    this.altPhoneNumber,
    this.address,
    this.specialNotes,
    this.isDimondUse,
    this.subTotal,
    this.dimondOff,
    this.discount,
    this.deliveryCharge,
    this.grandTotal,
    this.couponCode,
    this.isCouponUse,
  });

  String? id;
  List<Cart?>? cart;
  String? fullName;
  String? phoneNumber;
  String? altPhoneNumber;
  String? address;
  String? specialNotes;
  bool? isDimondUse;
  int? subTotal;
  int? dimondOff;
  int? discount;
  int? deliveryCharge;
  int? grandTotal;
  dynamic couponCode;
  bool? isCouponUse;

  factory CheckOut.fromJson(Map<String, dynamic> json) => CheckOut(
    id: json["id"],
    cart: json["cart"] == null ? [] : List<Cart?>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
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
    "cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x!.toJson())),
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

class Cart {
  Cart({
    this.id,
    this.product,
    this.createdBy,
    this.quantity,
    this.productId,
  });

  String? id;
  Product? product;
  String? createdBy;
  int? quantity;
  String? productId;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    product: Product.fromJson(json["product"]),
    createdBy: json["created_by"],
    quantity: json["quantity"],
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product!.toJson(),
    "created_by": createdBy,
    "quantity": quantity,
    "product_id": productId,
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.shortName,
    this.slug,
    this.regularPrice,
    this.salePrice,
    this.stockAvailable,
    this.permalink,
    this.cp,
    this.shortDescription,
    this.longDescription,
    this.weightInGrams,
    this.bestBy,
    this.rating,
    this.reviews,
    this.productImages,
    this.stockQuantity,
    this.categories,
  });

  String? id;
  String? name;
  String? shortName;
  String? slug;
  int? regularPrice;
  int? salePrice;
  bool? stockAvailable;
  String? permalink;
  String? cp;
  String? shortDescription;
  String? longDescription;
  dynamic weightInGrams;
  DateTime? bestBy;
  Rating? rating;
  List<Review?>? reviews;
  List<ProductImage?>? productImages;
  int? stockQuantity;
  List<Category?>? categories;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    shortName: json["short_name"],
    slug: json["slug"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    stockAvailable: json["stock_available"],
    permalink: json["permalink"],
    cp: json["cp"],
    shortDescription: json["short_description"],
    longDescription: json["long_description"],
    weightInGrams: json["weight_in_grams"],
    bestBy: DateTime.parse(json["Best_BY"]),
    rating: Rating.fromJson(json["rating"]),
    reviews: json["reviews"] == null ? [] : List<Review?>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    productImages: json["product_images"] == null ? [] : List<ProductImage?>.from(json["product_images"]!.map((x) => ProductImage.fromJson(x))),
    stockQuantity: json["stock_quantity"],
    categories: json["categories"] == null ? [] : List<Category?>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_name": shortName,
    "slug": slug,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "stock_available": stockAvailable,
    "permalink": permalink,
    "cp": cp,
    "short_description": shortDescription,
    "long_description": longDescription,
    "weight_in_grams": weightInGrams,
    "Best_BY": "${bestBy!.year.toString().padLeft(4, '0')}-${bestBy!.month.toString().padLeft(2, '0')}-${bestBy!.day.toString().padLeft(2, '0')}",
    "rating": rating!.toJson(),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x!.toJson())),
    "product_images": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x!.toJson())),
    "stock_quantity": stockQuantity,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x!.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.description,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.isProductCategory,
  });

  String? id;
  String? name;
  String? image;
  String? description;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isProductCategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isProductCategory: json["is_product_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "slug": slug,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_product_category": isProductCategory,
  };
}

class ProductImage {
  ProductImage({
    this.id,
    this.name,
    this.product,
    this.isFeaturedImage,
  });

  String? id;
  String? name;
  String? product;
  bool? isFeaturedImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    name: json["name"],
    product: json["product"],
    isFeaturedImage: json["is_featured_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product": product,
    "is_featured_image": isFeaturedImage,
  };
}

class Rating {
  Rating({
    this.gradeAvg,
  });

  int? gradeAvg;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    gradeAvg: json["grade__avg"],
  );

  Map<String, dynamic> toJson() => {
    "grade__avg": gradeAvg,
  };
}

class Review {
  Review({
    this.id,
    this.grade,
    this.review,
    this.product,
    this.createdBy,
  });

  String? id;
  String? grade;
  String? review;
  String? product;
  CreatedBy? createdBy;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    grade: json["grade"],
    review: json["review"],
    product: json["product"],
    createdBy: CreatedBy.fromJson(json["created_by"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grade": grade,
    "review": review,
    "product": product,
    "created_by": createdBy!.toJson(),
  };
}

class CreatedBy {
  CreatedBy({
    this.id,
    this.fullName,
    this.username,
    this.profilePhoto,
  });

  String? id;
  String? fullName;
  String? username;
  dynamic profilePhoto;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    fullName: json["full_name"],
    username: json["username"],
    profilePhoto: json["profile_photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "username": username,
    "profile_photo": profilePhoto,
  };
}

class ProfilePhotoClass {
  ProfilePhotoClass({
    this.id,
    this.name,
    this.pictureOff,
  });

  String? id;
  String? name;
  String? pictureOff;

  factory ProfilePhotoClass.fromJson(Map<String, dynamic> json) => ProfilePhotoClass(
    id: json["id"],
    name: json["name"],
    pictureOff: json["picture_off"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture_off": pictureOff,
  };
}
