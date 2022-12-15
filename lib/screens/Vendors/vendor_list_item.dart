import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/config/constants.dart';
import 'package:frontend/models/Vendor.dart';
import 'package:frontend/screens/Products/product_screen.dart';
import 'package:flutter/src/widgets/image.dart' as image_module;

class VendorListItem extends StatefulWidget {
  final Vendor vendor;

  const VendorListItem({Key? key, required this.vendor}) : super(key: key);

  @override
  State<VendorListItem> createState() => _VendorListItemState();
}

class _VendorListItemState extends State<VendorListItem> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final Vendor vendor = widget.vendor;

    final List<Widget> imageSliders = vendor.images
        .map((item) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: image_module.Image.network(item.pictureUrl,
                height: 150, width: double.infinity, fit: BoxFit.cover)))
        .toList();

    return Center(
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeIn,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: const Color.fromRGBO(0, 0, 0, 50), width: 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ProductScreen(
                            vendor: vendor,
                          ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // CarouselSlider(
                  //   items: imageSliders,
                  //   options:
                  //       CarouselOptions(enlargeCenterPage: true, height: 200),
                  //   carouselController: _controller,
                  // ),
                  imageSliders[0],
                  const SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(9, 1, 1, 1),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vendor.shopName,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  vendor.category,
                                  style: const TextStyle(
                                      color: Constants.grey2,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400),
                                )
                              ]),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "15 Min",
                                style: TextStyle(
                                    color: Constants.grey2,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
                              ),
                              Divider(
                                height: 5,
                                thickness: 10,
                                color: Constants.grey2,
                              ),
                              Text("₹ 200 for two",
                                  style: TextStyle(
                                      color: Constants.grey2,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
