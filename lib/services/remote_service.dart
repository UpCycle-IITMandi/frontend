import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();

  Future<List<Vendor>?> getVendors() async {
    var uri = Uri.parse('http://172.16.9.96:3000/vendors');
    print("hand >>");
    var response = await client.get(uri);
    print("<<< shake");
    if (response.statusCode == 200) {
      var res = response.body;
      var vendors = json.decode(res);
      print(vendors);
      return List<Vendor>.from(vendors.map((x) => Vendor.fromJson(x)));
    } else {
      throw ErrorDescription("cannot get");
    }
  }

  Future<http.Response> createUser(String name, String campus) async{
    return client.post(
        Uri.parse('http://172.16.9.96:3000/createUser'),
        headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'name': name,
        'campus': campus,
      }),
    );
  }

  Future<http.Response> getUser(String __email) async{
    return client.post(
      Uri.parse('http://172.16.9.96:3000/getUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': __email,
      }),
    );
  }
}
