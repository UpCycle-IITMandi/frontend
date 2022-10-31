import 'package:meta/meta.dart';
import 'dart:convert';

class Vendor {
  Vendor({
    required this.id,
    required this.shopName,
    required this.vendorId,
    required this.ownerName,
    required this.upiId,
    required this.address,
    required this.images,
    required this.messageOnOrder,
    required this.additionalDetailsMessage,
    required this.category,
    required this.contactNumber,
    required this.openingHour,
    required this.closingHour,
    required this.password,
    required this.distanceFromSouthCampus,
    required this.distanceFromNorthCampus,
    required this.estimatedCostForTwo,
    required this.orders,
    required this.inventory,
  });

  String id;
  String shopName;
  String vendorId;
  String ownerName;
  String upiId;
  String address;
  List<Image> images;
  String messageOnOrder;
  String additionalDetailsMessage;
  String category;
  String contactNumber;
  String openingHour;
  String closingHour;
  String password;
  String distanceFromSouthCampus;
  String distanceFromNorthCampus;
  int estimatedCostForTwo;
  List<dynamic> orders;
  List<Inventory> inventory;

  factory Vendor.fromRawJson(String str) => Vendor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["_id"],
        shopName: json["shopName"],
        vendorId: json["vendorId"],
        ownerName: json["ownerName"],
        upiId: json["upiId"],
        address: json["address"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        messageOnOrder: json["messageOnOrder"],
        additionalDetailsMessage: json["additionalDetailsMessage"],
        category: json["category"],
        contactNumber: json["contactNumber"],
        openingHour: json["openingHour"],
        closingHour: json["closingHour"],
        password: json["password"],
        distanceFromSouthCampus: json["distanceFromSouthCampus"],
        distanceFromNorthCampus: json["distanceFromNorthCampus"],
        estimatedCostForTwo: json["estimatedCostForTwo"],
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
        inventory: List<Inventory>.from(
            json["inventory"].map((x) => Inventory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "shopName": shopName,
        "vendorId": vendorId,
        "ownerName": ownerName,
        "upiId": upiId,
        "address": address,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "messageOnOrder": messageOnOrder,
        "additionalDetailsMessage": additionalDetailsMessage,
        "category": category,
        "contactNumber": contactNumber,
        "openingHour": openingHour,
        "closingHour": closingHour,
        "password": password,
        "distanceFromSouthCampus": distanceFromSouthCampus,
        "distanceFromNorthCampus": distanceFromNorthCampus,
        "estimatedCostForTwo": estimatedCostForTwo,
        "orders": List<dynamic>.from(orders.map((x) => x)),
        "inventory": List<dynamic>.from(inventory.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    required this.publicId,
    required this.pictureUrl,
  });

  String publicId;
  String pictureUrl;

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        publicId: json["publicId"],
        pictureUrl: json["pictureUrl"],
      );

  Map<String, dynamic> toJson() => {
        "publicId": publicId,
        "pictureUrl": pictureUrl,
      };
}

class Inventory {
  Inventory({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.inStock,
    required this.imageUrl,
  });

  String id;
  String name;
  String description;
  int cost;
  bool inStock;
  String imageUrl;

  factory Inventory.fromRawJson(String str) =>
      Inventory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cost: json["cost"],
        inStock: json["inStock"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "cost": cost,
        "inStock": inStock,
        "imageUrl": imageUrl,
      };
}
