import 'package:flutter/widgets.dart';
import 'package:frontend/models/Product.dart';

class MyAction<A, B> {
  final A value;
  final B type;
  MyAction(this.value, this.type);
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem(this.product, this.quantity);
}

@immutable
class AppState {
  final List<CartItem> cartItems;

  const AppState({this.cartItems = const []});
}
