import 'dart:convert';

class Vendor {
  Vendor({
    required this.vendorId,
    required this.shopName,
    required this.images,
  });

  int vendorId;
  String shopName;
  List<String> images;

  factory Vendor.fromRawJson(String str) => Vendor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        vendorId: json["vendor_id"],
        shopName: json["shop_name"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "shop_name": shopName,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
