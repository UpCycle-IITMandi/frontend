import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();

  Future<List<Vendor>?> getVendors() async {
    var uri = Uri.parse('http://192.168.43.67:3000/vendors');
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
}
