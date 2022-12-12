import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/actions/actions.dart';
import 'package:frontend/models/Product.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/models/app_state.dart';
import 'package:intl/intl.dart';

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
    final CarouselController controller = CarouselController();

    // final List<Widget> imageSliders = product.imageUrl
    //     .map((item) => ClipRRect(
    //         borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    //         child: Image.network(item, fit: BoxFit.cover)))
    //     .toList();

    final currency = NumberFormat.simpleCurrency(
        locale: 'en_IN', name: 'INR', decimalDigits: 2);

    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          children: [
            // CarouselSlider(
            //   items: imageSliders,
            //   options: CarouselOptions(enlargeCenterPage: true, height: 200),
            //   carouselController: _controller,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 150,
                child: Column(
                  children: [
                    Container(
                      height: 125,
                      width: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    AddToCart(
                        product: Product(
                            productId: product.id,
                            productName: product.name,
                            price: product.cost,
                            veg: true,
                            stars: 4,
                            images: [product.imageUrl])),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent.shade200),
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
          ],
        ),
      ),
    );
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
      return TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor:
              MaterialStateProperty.all(Colors.orangeAccent.shade200),
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
