import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/screens/Products/product_screen.dart';

class VendorListItem extends StatefulWidget {
  final Vendor vendor;

  const VendorListItem({Key? key, required this.vendor}) : super(key: key);

  @override
  State<VendorListItem> createState() => _VendorListItemState();
}

class _VendorListItemState extends State<VendorListItem> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final Vendor vendor = widget.vendor;

    final List<Widget> imageSliders = vendor.images
        .map((item) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(item, fit: BoxFit.cover)))
        .toList();

    return Center(
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeIn,
        height: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: const Color.fromRGBO(0, 0, 0, 50), width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ProductScreen(
                            vendor: vendor,
                          ))));
            },
            child: Column(
              children: [
                CarouselSlider(
                  items: imageSliders,
                  options:
                      CarouselOptions(enlargeCenterPage: true, height: 200),
                  carouselController: _controller,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 1, 0, 1),
                    alignment: Alignment.centerLeft,
                    child: Column(children: const [
                      Text(
                        "Chawla's",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Text(
                        "Test test",
                        style: TextStyle(color: Colors.black, fontSize: 9),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
