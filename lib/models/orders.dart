// To parse this JSON data, do
//
//     final orderLoad = orderLoadFromJson(jsonString);

import 'dart:convert';

OrderLoad orderLoadFromJson(String str) => OrderLoad.fromJson(json.decode(str));

String orderLoadToJson(OrderLoad data) => json.encode(data.toJson());

class OrderLoad {
  OrderLoad({
    required this.success,
    required this.vendors,
    required this.message,
  });

  bool success;
  List<OrderVendor> vendors;
  String message;

  factory OrderLoad.fromJson(Map<String, dynamic> json) => OrderLoad(
        success: json["success"],
        vendors: List<OrderVendor>.from(
            json["vendors"].map((x) => OrderVendor.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "vendors": List<dynamic>.from(vendors.map((x) => x.toJson())),
        "message": message,
      };
}

class OrderVendor {
  OrderVendor({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.orderDescription,
    required this.cost,
    required this.buyerMessage,
    required this.sellerMessage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String userId;
  String vendorId;
  List<OrderDescription> orderDescription;
  int cost;
  String buyerMessage;
  String sellerMessage;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory OrderVendor.fromJson(Map<String, dynamic> json) => OrderVendor(
        id: json["_id"],
        userId: json["userId"],
        vendorId: json["vendorId"],
        orderDescription: List<OrderDescription>.from(
            json["orderDescription"].map((x) => OrderDescription.fromJson(x))),
        cost: json["cost"],
        buyerMessage: json["buyerMessage"],
        sellerMessage: json["sellerMessage"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "vendorId": vendorId,
        "orderDescription":
            List<dynamic>.from(orderDescription.map((x) => x.toJson())),
        "cost": cost,
        "buyerMessage": buyerMessage,
        "sellerMessage": sellerMessage,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class OrderDescription {
  OrderDescription({
    required this.quantity,
    required this.id,
  });

  int quantity;
  String id;

  factory OrderDescription.fromJson(Map<String, dynamic> json) =>
      OrderDescription(
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "_id": id,
      };
}
