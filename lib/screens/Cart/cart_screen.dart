import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/actions/actions.dart';
import 'package:frontend/config/constants.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/services/remote_service.dart';
import 'package:http/http.dart';
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
    TextEditingController messageController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
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
              builder: (context, vm) {
                final cartItems = vm;
                if (cartItems.isEmpty) {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Empty Cart.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return Column(children: [
                  Expanded(
                    child: CartItemWidget(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        TextField(
                            cursorColor: Constants.grey3,
                            controller: messageController,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 7, bottom: 3),
                              border: InputBorder.none,
                              hintText: 'Add a message for the restaurant..',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        CheckoutButton(
                          messageController: messageController,
                        ),
                      ],
                    ),
                  ),
                ]);
              })
        ]));
  }
}

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({
    Key? key,
    required this.messageController,
  }) : super(key: key);
  final TextEditingController messageController;

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  final currency = NumberFormat.simpleCurrency(
      locale: 'en_IN', name: 'INR', decimalDigits: 2);

  Future<Response>? order;
  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    final cartItems = StoreProvider.of<AppState>(context).state.cartItems;
    final vendorId = StoreProvider.of<AppState>(context).state.vendorId;
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Constants.green1),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Constants.green1))),
      ),
      onPressed: _clicked
          ? null
          : () {
              setState(() {
                order = RemoteService().addOrder(
                    cartItems, vendorId!, widget.messageController.text);
                order!.then((value) {
                  if (value.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Order Placed Successfully'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Order Failed'),
                    ));
                  }
                });
                order!.catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Order Failed'),
                  ));
                });
                _clicked = true;
              });
            },
      child: Text(
          "${currency.format(cartItems.fold<int>(0, (previousValue, element) => previousValue + element.product.price * element.quantity))} | Proceed to Checkout",
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  CartItemWidget({Key? key}) : super(key: key);

  final currency = NumberFormat.simpleCurrency(
      locale: 'en_IN', name: 'INR', decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    final cartItems = StoreProvider.of<AppState>(context).state.cartItems;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        image: NetworkImage(cartItems[index].product.images[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          currency.format(cartItems[index].product.price),
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
                          StoreProvider.of<AppState>(context).dispatch(MyAction(
                              CartItem(cartItems[index].product,
                                  cartItems[index].quantity + 1),
                              CartActions.editCartAction));
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
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
                          StoreProvider.of<AppState>(context).dispatch(MyAction(
                              CartItem(cartItems[index].product,
                                  cartItems[index].quantity - 1),
                              CartActions.editCartAction));
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}
