
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/actions/actions.dart';
import 'package:frontend/config/constants.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/screens/Cart/cart_screen.dart';
import 'package:frontend/screens/Products/product_item.dart';
import 'package:frontend/screens/Profile/my_account.dart';
import 'package:intl/intl.dart';

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
                        child:
                            const Text('Yes', style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Constants.grey3,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          title: Text(
            vendor.shopName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          elevation: 0,
          backgroundColor: Constants.grey8,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: VendorDetails(vendor: vendor),
          ),
        ),
        body: MenuWidget(products: products),
      ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Inventory> products;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  var productsState = <Inventory>[];
  var searchState = "";
  bool vegState = true;
  final currency = NumberFormat.simpleCurrency(
      locale: 'en_IN', name: 'INR', decimalDigits: 2);

  @override
  initState() {
    super.initState();
    productsState = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 5,
      ),
      const Text(
        "MENU",
        style: TextStyle(color: Constants.grey3),
      ),
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Constants.grey4,
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchState = value;
              });
            },
            cursorColor: Constants.grey3,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 7, bottom: 3),
              hintText: "Search for dishes",
              hintStyle: const TextStyle(color: Constants.grey3, fontSize: 12),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    productsState = widget.products
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(searchState.toLowerCase()))
                        .toList();
                  });
                },
                color: Constants.grey3,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Constants.grey3, width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Constants.grey3, width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Text(
      //       "Veg",
      //       style: TextStyle(color: Constants.grey3),
      //     ),
      //     Switch(
      //       value: vegState,
      //       onChanged: (value) {
      //         setState(() {
      //           vegState = value;
      //           if (value) {
      //             productsState = widget.products
      //                 .where((element) => element.isVeg)
      //                 .toList();
      //           } else {
      //             productsState = widget.products;
      //           }
      //         });
      //       },
      //       activeTrackColor: Colors.lightGreenAccent,
      //       activeColor: Colors.green,
      //     ),
      //     Text(
      //       "Non-Veg",
      //       style: TextStyle(color: Constants.grey3),
      //     ),
      //   ],
      // ),
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: productsState.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 5),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 5),
                        child: ProductListItem(product: productsState[index])),
                    const SizedBox(height: 5),
                  ],
                );
              })),
      // connect to store
      Positioned(
        bottom: 0,
        child: StoreConnector<AppState, List<CartItem>>(
          converter: (store) => store.state.cartItems,
          builder: (context, cartItems) {
            final int total = cartItems.fold(
                0,
                (previousValue, element) =>
                    previousValue + (element.quantity * element.product.price));
            return Container(
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Constants.green1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "View Cart",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    currency.format(total),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => const CartScreen());
                        Navigator.push(context, route);
                      },
                      child:
                          const Icon(Icons.arrow_forward_ios, color: Colors.white)),
                ],
              ),
            );
          },
        ),
      )
    ]);
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: const [
                        Text("OPEN NOW",
                            style: TextStyle(
                              color: Constants.green1,
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                            )),
                        Text("11:30 am - 1:00 am (Today)",
                            style: TextStyle(
                              color: Constants.grey7,
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                            )),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("₹ 250",
                            style: TextStyle(
                              color: Constants.grey3,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                            )),
                        Text("Cost for two",
                            style: TextStyle(
                              color: Constants.grey7,
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                            )),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("15 min",
                            style: TextStyle(
                              color: Constants.grey3,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                            )),
                        Text(
                          "Delivery Time",
                          style: TextStyle(
                            color: Constants.grey7,
                            fontWeight: FontWeight.w400,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
