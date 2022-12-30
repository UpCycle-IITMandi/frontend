import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:frontend/models/vendor.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/models/orders.dart';
import 'package:frontend/utils/get_auth_token.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://dark-mummy-27672.herokuapp.com';

class RemoteService {
  static var client = http.Client();

  Future<String> get authToken => getAuthToken().then((value) => value!);

  Future<http.Response> addOrder(
      List<CartItem> cartItems, String vendorId, String text) async {
    return client.post(Uri.parse('$baseUrl/api/v1/order/add'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': await authToken,
        },
        body: jsonEncode({
          "vendorId": vendorId,
          "order": cartItems
              .map((e) => {"id": e.product.productId, "quantity": e.quantity})
              .toList(),
          "message": text
        }));
  }

  Future<OrderLoad> getOrders() async {
    var response = await client.post(
      Uri.parse('$baseUrl/api/v1/order/getAll'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': await authToken,
      },
    );
    if (response.statusCode == 200) {
      return orderLoadFromJson(response.body);
    } else {
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
      return List<Vendor>.from(vendors.map((x) => Vendor.fromJson(x)));
    } else {
      throw ErrorDescription("cannot get");
    }
  }

  Future<http.Response> createUser(
      String name, String upiID, String campus, String hostel) async {
    return client.post(
      Uri.parse('$baseUrl/api/v1/user/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': await authToken,
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'hostel': hostel,
        'upiId': upiID,
        'campus': campus,
      }),
    );
  }

  Future<http.Response> updateUser(String photo, String name, String upiID,
      String campus, String hostel) async {
    return client.post(
      Uri.parse('$baseUrl/api/v1/user/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': await authToken,
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

  Future<http.Response> getUser(String email) async {
    return client.get(
      Uri.parse('$baseUrl/api/v1/auth/authCheck'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': await authToken,
      },
    );
  }

  Future<http.Response> createOrder(String vendorId, String vendorName,
      String vendorUpiId, String vendorHostel) async {
    return client.post(
      Uri.parse('$baseUrl/api/v1/order/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': await authToken,
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
