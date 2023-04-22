class CartModel {
  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.productId,
    required this.checkBox,
  });

  String id;
  Product product;
  int quantity;
  String productId;
  bool checkBox;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        productId: json["product_id"],
        checkBox: json["check_box"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
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
    required this.regularPrice,
    this.salePrice,
    required this.stockAvailable,
    required this.productImages,
    required this.stockQuantity,
    required this.priceItem,
  });

  String id;
  String name;
  String shortName;
  double regularPrice;
  double? salePrice;
  bool stockAvailable;
  List<ProductImage> productImages;
  int stockQuantity;
  double priceItem;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        shortName: json["short_name"],
        regularPrice: json["regular_price"].toDouble(),
        salePrice: (json["sale_price"] != null && json["sale_price"] != 0) ? json["sale_price"]?.toDouble() : null,
        stockAvailable: json["stock_available"],
        productImages: List<ProductImage>.from(
            json["product_images"].map((x) => ProductImage.fromJson(x))),
        stockQuantity: json["stock_quantity"],
        priceItem: 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_name": shortName,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "stock_available": stockAvailable,
        "product_images":
            List<dynamic>.from(productImages.map((x) => x.toJson())),
        "stock_quantity": stockQuantity,
        "priceItem": 0.0,
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
