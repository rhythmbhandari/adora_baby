

import 'dart:convert';

Hot hotSalesFromJson(String str) => Hot.fromJson(json.decode(str));

String hotSalesToJson(Hot data) => json.encode(data.toJson());

class Hot {
  Hot({
    this.next,
    this.previous,
    required this.count,
    required this.data,
  });

  dynamic next;
  dynamic previous;
  int count;
  List<Datum> data;

  factory Hot.fromJson(Map<String, dynamic> json) => Hot(
    next: json["next"],
    previous: json["previous"],
    count: json["count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next": next,
    "previous": previous,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.regularPrice,
    required this.salePrice,
    required this.stockAvailable,
    required this.permalink,
    required this.cp,
    required this.shortDescription,
    required this.longDescription,
    this.weightInGrams,
    required this.bestBy,
    required this.rating,
    required this.reviews,
    required this.productImages,
  });

  String id;
  String name;
  String shortName;
  String slug;
  int regularPrice;
  int salePrice;
  bool stockAvailable;
  String permalink;
  String cp;
  String shortDescription;
  String longDescription;
  dynamic weightInGrams;
  DateTime bestBy;
  Rating rating;
  List<Review> reviews;
  List<ProductImage> productImages;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
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
    "Best_BY": bestBy.toIso8601String(),
    "rating": rating.toJson(),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
  };
}

class ProductImage {
  ProductImage({
    required this.id,
    required this.name,
    required this.product,
    required this.isFeaturedImage,
  });

  String id;
  String name;
  String product;
  bool isFeaturedImage;

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
    required this.gradeAvg,
  });

  int gradeAvg;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    gradeAvg: json["grade__avg"],
  );

  Map<String, dynamic> toJson() => {
    "grade__avg": gradeAvg,
  };
}

class Review {
  Review({
    required this.id,
    required this.grade,
    required this.review,
    required this.product,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String grade;
  String review;
  String product;
  CreatedBy createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    grade: json["grade"],
    review: json["review"],
    product: json["product"],
    createdBy: CreatedBy.fromJson(json["created_by"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grade": grade,
    "review": review,
    "product": product,
    "created_by": createdBy.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.fullName,
    required this.username,
  });

  String id;
  String fullName;
  String username;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    fullName: json["full_name"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "username": username,
  };
}
