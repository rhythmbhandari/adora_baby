class HotSalesData {
  HotSalesData({
    this.next,
    this.previous,
    required this.count,
    required this.data,
  });

  dynamic next;
  dynamic previous;
  num count;
  List<HotSales> data;

  factory HotSalesData.fromJson(Map<String, dynamic> json) => HotSalesData(
    next: json["next"],
    previous: json["previous"],
    count: json["count"],
    data: List<HotSales>.from(json["data"].map((x) => HotSales.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next": next,
    "previous": previous,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}


class HotSales {
  HotSales({
    required this.id,
    required this.name,
    required this.shortName,
    required this.regularPrice,
    required this.slug,
    required this.salePrice,
    required this.stockAvailable,
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
  String shortDescription;
  String longDescription;
  dynamic weightInGrams;
  DateTime bestBy;
  Rating rating;
  List<Review> reviews;
  List<ProductImage> productImages;


  factory HotSales.fromJson(Map<String, dynamic> json) => HotSales(
    id: json["id"],
    name: json["name"] ,
    shortName: json["short_name"],
    slug: json["slug"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    stockAvailable: json["stock_available"],
    shortDescription: json["short_description"],
    longDescription: json["long_description"],
    rating: Rating.fromJson(json["rating"]),
    weightInGrams: json["weight_in_grams"],
    bestBy: DateTime.parse(json["Best_BY"]),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_name": shortName,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "stock_available": stockAvailable,
    "short_description": shortDescription,
    "long_description": longDescription,
    "weight_in_grams": weightInGrams,
    "rating": rating.toJson(),
    "Best_BY": bestBy.toIso8601String(),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
  };
}

class ProductImage {
  ProductImage({
    required this.name,
    required this.isFeaturedImage,
  });

  String name;
  bool isFeaturedImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    name: json["name"],
    isFeaturedImage: json["is_featured_image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "is_featured_image": isFeaturedImage,
  };
}

class Rating {
  Rating({
    required this.gradeAvg,
  });

  double gradeAvg;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    gradeAvg: json["grade__avg"] ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "grade__avg": gradeAvg ?? 0.0,
  };
}

//   double gradeAvg;
//
//   factory Rating.fromJson(Map<String, dynamic> json) => Rating(
//     gradeAvg: json["grade__avg"] ?? 0.0,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "grade__avg": gradeAvg,
//   };
// }

class Review {
  Review({
    required this.id,
    required this.grade,
    required this.review,
    required this.product,
    required this.createdBy,
    required this.updatedAt,
  });

  String id;
  String grade;
  String review;
  String product;
  CreatedBy createdBy;
  DateTime updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    grade: json["grade"],
    review: json["review"],
    product: json["product"],
    createdBy: CreatedBy.fromJson(json["created_by"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grade": grade,
    "review": review,
    "product": product,
    "created_by": createdBy.toJson(),
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
