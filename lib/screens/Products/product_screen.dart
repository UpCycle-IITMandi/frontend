import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/actions/actions.dart';
import 'package:frontend/config/constants.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/screens/Products/product_item.dart';
import 'package:frontend/screens/Profile/my_account.dart';

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
                        child:
                            const Text('Yes', style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ));
      },
      child: Scaffold(
        backgroundColor: Constants.grey6,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Constants.grey3,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          title: null,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyAccount(),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(FirebaseAuth
                          .instance.currentUser!.photoURL ??
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                ),
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          // title: const Text('Village Square',
          //     style: TextStyle(
          //       color: Colors.black,
          //     )),
          elevation: 0,
          backgroundColor: Colors.grey.shade400,
          bottom: PreferredSize(
            child: VendorDetails(vendor: vendor),
            preferredSize: Size.fromHeight(200),
          ),
        ),
        body: Column(children: [
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
              borderRadius: BorderRadius.circular(25), color: Colors.white),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(vendor.images[0].pictureUrl),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Text(vendor.address,
                      //     textAlign: TextAlign.center,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: TextStyle(
                      //       color: Colors.grey.shade300,
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 12,
                      //     )),
                      Text(
                        vendor.category,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Constants.grey2,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: const [
                              Text("OPEN NOW",
                                  style: TextStyle(
                                    color: Constants.green1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  )),
                              Text("11:30 am - 1:00 am (Today)",
                                  style: TextStyle(
                                    color: Constants.grey7,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8,
                                  )),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade200,
                            thickness: 10,
                          ),
                          Column(
                            children: const [
                              Text("₹ 250",
                                  style: TextStyle(
                                    color: Constants.grey3,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  )),
                              Text("Cost for two",
                                  style: TextStyle(
                                    color: Constants.grey7,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  )),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade200,
                            thickness: 10,
                          ),
                          Column(
                            children: const [
                              Text("15 min",
                                  style: TextStyle(
                                    color: Constants.grey3,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  )),
                              Text(
                                "Delivery Time",
                                style: TextStyle(
                                  color: Constants.grey7,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
