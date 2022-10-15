import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/actions/actions.dart';
import 'package:frontend/models/Product.dart';
import 'package:frontend/models/app_state.dart';

class ProductListItem extends StatefulWidget {
  final Product product;
  const ProductListItem({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final Product product = widget.product;
    final CarouselController _controller = CarouselController();

    final List<Widget> imageSliders = product.images
        .map((item) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(item, fit: BoxFit.cover)))
        .toList();

    print("inside product item");
    print(product.productName);
    return Row(
      children: [
        Column(
          children: [
            // CarouselSlider(
            //   items: imageSliders,
            //   options: CarouselOptions(enlargeCenterPage: true, height: 200),
            //   carouselController: _controller,
            // ),
            Image.network(product.images[0]),
            StoreConnector<AppState, void Function()>(builder: (context, vm) {
              return ElevatedButton.icon(
                  onPressed: vm,
                  icon: Icon(Icons.plus_one),
                  label: Text(
                    "ADD",
                    style: TextStyle(color: Colors.black),
                  ));
            }, converter: (store) {
              return () {
                store.dispatch(
                    MyAction(CartItem(product, 1), CartActions.AddItemAction));
              };
            }),
            Column(
              children: [
                Text(
                  product.veg ? "Veg" : "Nonveg",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  product.productName,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  product.price.toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
