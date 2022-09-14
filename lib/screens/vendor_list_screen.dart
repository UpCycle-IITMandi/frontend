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
            return ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 5),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 5),
                          child: VendorListItem(vendor: snapshot.data![index])),
                      const SizedBox(height: 5),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
