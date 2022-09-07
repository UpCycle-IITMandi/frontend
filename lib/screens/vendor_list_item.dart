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

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        height: 300,
        width: 350,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 200, child: Image.network(vendor.images[0])),
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
    );
  }
}
