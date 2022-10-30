import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/actions/actions.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/models/app_state.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColorSelector = Theme.of(context).primaryColor;
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text("Cart",
              style: TextStyle(
                color: Colors.black,
              )),
          backgroundColor: primaryColorSelector,
        ),
        body: Column(children: [
          const SizedBox(height: 10),
          StoreConnector<AppState, List<CartItem>>(
              converter: (store) => store.state.cartItems,
              builder: (context, cartItems) {
                final currency = NumberFormat.simpleCurrency(
                    locale: 'en_IN', name: 'INR', decimalDigits: 2);

                return Expanded(
                    child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            cartItems[index].product.images[0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItems[index].product.productName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          currency.format(
                                              cartItems[index].product.price),
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.orangeAccent.shade200,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          StoreProvider.of(context).dispatch(
                                              MyAction(
                                                  CartItem(
                                                      cartItems[index].product,
                                                      cartItems[index]
                                                              .quantity +
                                                          1),
                                                  CartActions.EditCartAction));
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      Text(
                                        cartItems[index].quantity.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          StoreProvider.of(context).dispatch(
                                              MyAction(
                                                  CartItem(
                                                      cartItems[index].product,
                                                      cartItems[index]
                                                              .quantity -
                                                          1),
                                                  CartActions.EditCartAction));
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                    ],
                                  )
                                ],
                              ));
                        }));
              })
        ]));
  }
}