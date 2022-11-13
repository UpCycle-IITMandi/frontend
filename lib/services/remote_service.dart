import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();

  Future<List<Vendor>?> getVendors() async {
    var uri = Uri.parse('http://192.168.43.67:3000/api/v1/vendor/getAll');
    print("hand >>");
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

  Future<http.Response> updateUser(String authToken, String name, String upiID,
      String campus, String hostel) async {
    return client.post(
      Uri.parse('http://192.168.43.67:3000/api/v1/user/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
<<<<<<< Updated upstream
=======
      body: jsonEncode(<String, String>{
        'name': name,
        'hostel': hostel,
        'upiId': upiID,
        'campus': campus,
      }),
    );
  }

  Future<http.Response> createUser(String authToken, String name, String upiID,
      String campus, String hostel) async {
    return client.post(
      Uri.parse('$baseUrl/api/v1/user/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
>>>>>>> Stashed changes
      body: jsonEncode(<String, String>{
        'name': name,
        'hostel': hostel,
        'upiId': upiID,
        'campus': campus,
      }),
    );
  }

  Future<http.Response> getUser(String authToken, String __email) async {
    return client.get(
      Uri.parse('http://192.168.43.67:3000/api/v1/auth/authCheck'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authtoken': authToken,
      },
    );
  }

  Future<http.Response> createOrder(String authToken, String vendorId,
      String vendorName, String vendorUpiId, String vendorHostel) async {
    return client.post(
      Uri.parse('http://192.168.43.67:3000/api/v1/order/create'),
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
