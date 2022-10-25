import 'package:flutter/material.dart';
import 'package:frontend/models/Product.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/screens/HomePage/home_page_screen.dart';
import 'package:frontend/screens/Products/product_item.dart';
import 'package:frontend/services/remote_service.dart';

class ProductScreen extends StatefulWidget {
  final Vendor vendor;
  const ProductScreen({Key? key, required this.vendor}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future<List<Product>?>? products;

  @override
  void initState() {
    super.initState();
    products = RemoteService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final Vendor vendor = widget.vendor;
    var primaryColorSelector = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Warning"),
                content:
                    const Text("If you go back, the cart will be cleared."),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    //return true when click on "Yes"
                    child: Text('Yes'),
                  ),
                ],
              );
            });
      },
      child: Scaffold(
        backgroundColor: primaryColorSelector,
        appBar: AppBar(
          actions: const [
            CartAppBarWidget(),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(vendor.shopName,
              style: const TextStyle(
                color: Colors.black,
              )),
          backgroundColor: primaryColorSelector,
        ),
        body: Column(
          children: [
            SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Text(
                      vendor.shopName,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                )),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<Product>?>(
                stream: Stream.fromFuture(products!),
                builder: ((context, snapshot) {
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
                                  child: ProductListItem(
                                      product: snapshot.data![index])),
                              const SizedBox(height: 5),
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
