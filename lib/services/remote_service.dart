import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:frontend/models/Product.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();

  Future<List<Vendor>?> getVendors() async {
    var uri = Uri.parse('http://192.168.43.67:3000/vendors');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var res = response.body;
      var vendors = json.decode(res);
      return List<Vendor>.from(vendors.map((x) => Vendor.fromJson(x)));
    } else {
      throw ErrorDescription("cannot get");
    }
  }

  Future<List<Product>?> getProducts() async {
    var uri = Uri.parse('http://192.168.43.67:3000/products');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var res = response.body;
      var Products = json.decode(res);
      return List<Product>.from(Products.map((x) => Product.fromJson(x)));
    } else {
      throw ErrorDescription("cannot get");
    }
  }
}
