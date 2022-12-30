import 'package:flutter/material.dart';
import 'package:frontend/models/vendor.dart';
import './vendor_list_item.dart';
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
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 5),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child:
                                VendorListItem(vendor: snapshot.data![index])),
                        const SizedBox(height: 5),
                      ],
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
