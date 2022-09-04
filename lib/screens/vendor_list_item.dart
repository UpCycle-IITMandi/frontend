import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/services/remote_service.dart';

class VendorListItem extends StatefulWidget {
  final Vendor vendor;

  VendorListItem({Key? key, required this.vendor}) : super(key: key);

  @override
  State<VendorListItem> createState() =>
      _VendorListItemState(vendor: this.vendor);
}

class _VendorListItemState extends State<VendorListItem> {
  final Vendor vendor;

  _VendorListItemState({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          color: Colors.blueAccent,
          child: SizedBox(
            height: 300,
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: 200, child: Image.network(vendor.images[0])),
                      SizedBox(
                        child: Text(
                          vendor.shopName,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Flutter Open",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "Flutter Tutorial",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
