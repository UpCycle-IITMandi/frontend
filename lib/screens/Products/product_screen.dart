import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/actions/actions.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/screens/HomePage/home_page_screen.dart';
import 'package:frontend/screens/Products/product_item.dart';

class ProductScreen extends StatefulWidget {
  final Vendor vendor;
  const ProductScreen({Key? key, required this.vendor}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Inventory> products = widget.vendor.inventory;
    final Vendor vendor = widget.vendor;
    var primaryColorSelector = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async {
        if (StoreProvider.of<AppState>(context).state.cartItems.isEmpty) {
          return true;
        }
        return await showDialog(
            context: context,
            builder: (context) => Theme(
                  data: Theme.of(context)
                      .copyWith(dialogBackgroundColor: Colors.white),
                  child: AlertDialog(
                    title: const Text(
                      "Warning",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                        "If you go back, the cart will be cleared.",
                        style: TextStyle(fontSize: 10)),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.orangeAccent.shade200)),
                        onPressed: () => Navigator.of(context).pop(false),
                        //return false when click on "NO"
                        child: const Text('No', style: TextStyle(fontSize: 10)),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.orangeAccent.shade200)),
                        onPressed: () {
                          StoreProvider.of<AppState>(context).dispatch(
                              MyAction(null, CartActions.ClearCartAction));
                          Navigator.of(context).pop(true);
                        },
                        //return true when click on "Yes"
                        child: const Text('Yes', style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ));
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
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
        body: Column(children: [
          VendorDetails(vendor: vendor),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 5),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: ProductListItem(product: products[index])),
                        const SizedBox(height: 5),
                      ],
                    );
                  })),
        ]),
      ),
    );
  }
}

class ViewCart extends StatefulWidget {
  const ViewCart({Key? key}) : super(key: key);

  @override
  State<ViewCart> createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  @override
  Widget build(BuildContext context) {
    return const Text("View Cart");
  }
}

class VendorDetails extends StatelessWidget {
  const VendorDetails({
    Key? key,
    required this.vendor,
  }) : super(key: key);

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        vendor.shopName.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${vendor.category} | Open Now | 11:00 AM - 12:00 PM",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(vendor.address, style: const TextStyle(fontSize: 10)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
