
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/actions/actions.dart';
import 'package:frontend/config/constants.dart';
import 'package:frontend/models/Product.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/models/app_state.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class ProductListItem extends StatefulWidget {
  final Inventory product;
  const ProductListItem({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final Inventory product = widget.product;

    final currency = NumberFormat.simpleCurrency(
        locale: 'en_IN', name: 'INR', decimalDigits: 2);

    return StoreConnector<AppState, List<CartItem>>(
      converter: (store) => store.state.cartItems,
      builder: (context, cartItems) {
        final isAdded =
            cartItems.any((element) => element.product.productId == product.id);
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   product.veg ? "Veg" : "Nonveg",
                    // ),
                    Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currency.format(product.cost),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 9),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      children: [
                        Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(product.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (isAdded
                                ? ModifyQuantity(
                                    productId: product.id,
                                  )
                                : AddToCart(
                                    product: Product(
                                        productId: product.id,
                                        productName: product.name,
                                        price: product.cost,
                                        veg: true,
                                        stars: 4,
                                        images: [product.imageUrl]))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ModifyQuantity extends StatelessWidget {
  const ModifyQuantity({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Tuple2<int, void Function({bool inc})>>(
        builder: (context, vm) {
      return SizedBox(
        height: 48,
        child: Container(
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Constants.green1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  constraints: const BoxConstraints(maxHeight: 19),
                  onPressed: () => vm.item2(inc: false),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 16,
                  )),
              Text(
                vm.item1.toString(),
                style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              IconButton(
                  constraints: const BoxConstraints(maxHeight: 19),
                  onPressed: () => vm.item2(inc: true),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  )),
            ],
          ),
        ),
      );
    }, converter: (store) {
      var index = store.state.cartItems
          .indexWhere((element) => element.product.productId == productId);
      return Tuple2<int, void Function({bool inc})>.fromList([
        store.state.cartItems[index].quantity,
        ({bool inc = true}) {
          store.dispatch(MyAction(
              CartItem(store.state.cartItems[index].product,
                  store.state.cartItems[index].quantity + (inc ? 1 : -1)),
              CartActions.EditCartAction));
        }
      ]);
    });
  }
}

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, void Function()>(builder: (context, vm) {
      return OutlinedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Constants.green1),
          backgroundColor: MaterialStateProperty.all(Constants.green3),
          shape: MaterialStateProperty.all(
            const StadiumBorder(
              side: BorderSide(color: Constants.green1, width: 1),
            ),
          ),
        ),
        onPressed: vm,
        child: const Text(
          "Add to Cart",
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
        ),
      );
    }, converter: (store) {
      return () {
        store.dispatch(
            MyAction(CartItem(product, 1), CartActions.AddItemAction));
      };
    });
  }
}
