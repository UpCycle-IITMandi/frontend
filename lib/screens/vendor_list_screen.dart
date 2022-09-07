import 'package:flutter/material.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/screens/vendor_list_item.dart';
import 'package:frontend/services/remote_service.dart';

class VendorList extends StatefulWidget {
  const VendorList({Key? key}) : super(key: key);

  @override
  State<VendorList> createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  Future<List<Vendor>?>? vendors;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    vendors = RemoteService().getVendors();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vendor>?>(
        future: vendors,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, crossAxisSpacing: 0, mainAxisSpacing: 0),
                // padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                padding: const EdgeInsets.all(0),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return VendorListItem(vendor: snapshot.data![index]);
                });
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
