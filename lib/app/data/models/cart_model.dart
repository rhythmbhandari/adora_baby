class CartModel {
  CartModel({
    required this.id,
    required this.product,
    required this.createdBy,
    required this.quantity,
    required this.productId,
    required this.checkBox,
  });

  String id;
  Product product;
  String createdBy;
  int quantity;
  String productId;
  bool checkBox;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        createdBy: json["created_by"],
        quantity: json["quantity"],
        productId: json["product_id"],
        checkBox: json["check_box"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "created_by": createdBy,
        "quantity": quantity,
        "product_id": productId,
        "check_box": checkBox ?? false
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.regularPrice,
    this.salePrice,
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
    required this.stockQuantity,
    required this.categories,
    required this.priceItem,
  });

  String id;
  String name;
  String shortName;
  String slug;
  double regularPrice;
  double? salePrice;
  bool stockAvailable;
  String permalink;
  String cp;
  String shortDescription;
  String longDescription;
  dynamic weightInGrams;
  DateTime bestBy;
  Rating rating;
  List<dynamic> reviews;
  List<ProductImage> productImages;
  int stockQuantity;
  List<Category> categories;
  double priceItem;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        shortName: json["short_name"],
        slug: json["slug"],
        regularPrice: json["regular_price"].toDouble(),
        salePrice: json["sale_price"]?.toDouble() ,
        stockAvailable: json["stock_available"],
        permalink: json["permalink"],
        cp: json["cp"],
        shortDescription: json["short_description"],
        longDescription: json["long_description"],
        weightInGrams: json["weight_in_grams"],
        bestBy: DateTime.parse(json["Best_BY"]),
        rating: Rating.fromJson(json["rating"]),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        productImages: List<ProductImage>.from(
            json["product_images"].map((x) => ProductImage.fromJson(x))),
        stockQuantity: json["stock_quantity"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        priceItem: 0.0,
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
        "Best_BY":
            "${bestBy.year.toString().padLeft(4, '0')}-${bestBy.month.toString().padLeft(2, '0')}-${bestBy.day.toString().padLeft(2, '0')}",
        "rating": rating.toJson(),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "product_images":
            List<dynamic>.from(productImages.map((x) => x.toJson())),
        "stock_quantity": stockQuantity,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "priceItem": 0.0,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.isProductCategory,
  });

  String id;
  String name;
  String image;
  String description;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  bool isProductCategory;

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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_product_category": isProductCategory,
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
    this.gradeAvg,
  });

  dynamic gradeAvg;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        gradeAvg: json["grade__avg"],
      );

  Map<String, dynamic> toJson() => {
        "grade__avg": gradeAvg,
      };
}
