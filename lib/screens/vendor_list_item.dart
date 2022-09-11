import 'package:flutter/material.dart';
import 'package:frontend/models/Vendor.dart';

class VendorListItem extends StatefulWidget {
  final Vendor vendor;

  const VendorListItem({Key? key, required this.vendor}) : super(key: key);

  @override
  State<VendorListItem> createState() => _VendorListItemState();
}

class _VendorListItemState extends State<VendorListItem> {
  @override
  Widget build(BuildContext context) {
    final Vendor vendor = widget.vendor;

    return SizedBox(
      height: 250,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side:
              const BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 50)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Image.network(
              height: 200,
              vendor.images[0],
              fit: BoxFit.fill,
            ),
            Column(children: const [
              Text(
                "Chawla's",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Test test",
                style: TextStyle(color: Colors.black),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
