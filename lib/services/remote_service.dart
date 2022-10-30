import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();

  Future<List<Vendor>?> getVendors() async {
    var uri = Uri.parse('http://192.168.43.125:3000/api/v1/vendor/getAll');
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

  // Future<List<Product>?> getProducts() async {
  //   var uri = Uri.parse('http://192.168.43.125:3000/products');
  //   var response = await client.get(uri);
  //   if (response.statusCode == 200) {
  //     var res = response.body;
  //     var products = json.decode(res);
  //     return List<Product>.from(products.map((x) => Product.fromJson(x)));
  //   } else {
  //     throw ErrorDescription("cannot get");
  //   }
  // }
}
