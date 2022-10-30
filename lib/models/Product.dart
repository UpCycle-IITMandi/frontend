import 'dart:convert';

class Product {
  Product({
    required this.productId,
    required this.productName,
    required this.price,
    required this.veg,
    required this.stars,
    // required this.reviews,
    required this.images,
  });

  String productId;
  String productName;
  int price;
  bool veg;
  int stars;
  // int reviews;
  List<String> images;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productName: json["product_name"],
        price: json["price"],
        veg: json["veg"],
        stars: json["stars"],
        // reviews: json["reviews"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "price": price,
        "veg": veg,
        "stars": stars,
        // "reviews": reviews,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
