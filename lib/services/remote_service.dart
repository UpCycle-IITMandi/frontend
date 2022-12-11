import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/models/orders.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://dark-mummy-27672.herokuapp.com';

class RemoteService {
  static var client = http.Client();

  Future<http.Response> addOrder(String authToken) async {
    // AddOrders order = AddOrders(
    //     vendorId: "123",
    //     order: [Order(id: "3", quantity: 5)],
    //     message: "message done");
    // var body = await order.toJson();
    return client.post(
      Uri.parse('$baseUrl/api/v1/order/add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authtoken': authToken,
      },
      body: jsonEncode({
        "vendorId": "pizzabytes69",
        "order": [
          {"id": "farmHouse", "quantity": 2},
          {"id": "indiChickenTikka", "quantity": 3}
        ],
        "message": "Please give oregano and chilly flakes"
      }),
    );
  }

  Future<OrderLoad> getOrders(String authToken) async {
    print("1");

    print(authToken);
    var response = await http.get(
      Uri.parse('$baseUrl/api/v1/order/getAll'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
    );
    print("2");
    if (response.statusCode == 200) {
      print("4");
      // String body = json.decode(response.body);
      // print("object");
      return orderLoadFromJson(response.body);
    } else {
      print("5");
      throw ErrorDescription("cannot get");
    }
  }

  Future<List<Vendor>?> getVendors() async {
    var uri = Uri.parse('$baseUrl/api/v1/vendor/getAll');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var res = response.body;

      var body = json.decode(res);
      var vendors = body["vendors"];
      print(vendors);
      return List<Vendor>.from(vendors.map((x) => Vendor.fromJson(x)));
    } else {
      throw ErrorDescription("cannot get");
    }
  }

  Future<http.Response> createUser(String authToken, String name, String upiID,
      String campus, String hostel) async {
    return client.post(
      Uri.parse('$baseUrl/api/v1/user/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'hostel': hostel,
        'upiId': upiID,
        'campus': campus,
      }),
    );
  }

  Future<http.Response> updateUser(String authToken, String photo, String name,
      String upiID, String campus, String hostel) async {
    return client.post(
      Uri.parse('$baseUrl/api/v1/user/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
      body: jsonEncode(<String, String>{
        'photo': photo,
        'name': name,
        'hostel': hostel,
        'upiId': upiID,
        'campus': campus,
      }),
    );
  }

  Future<http.Response> getUser(String authToken, String __email) async {
    return client.get(
      Uri.parse('$baseUrl/api/v1/auth/authCheck'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
    );
  }

  Future<http.Response> createOrder(String authToken, String vendorId,
      String vendorName, String vendorUpiId, String vendorHostel) async {
    return client.post(
      Uri.parse('$baseUrl/api/v1/order/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
      body: jsonEncode(<String, String>{
        'vendorId': vendorId,
        'vendorName': vendorName,
        'vendorUpiId': vendorUpiId,
        'vendorHostel': vendorHostel,
      }),
    );
  }
}
