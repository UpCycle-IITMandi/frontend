import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/orders.dart';
import 'package:frontend/services/remote_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrderLoad order_details;

  Future<bool> getData() async {
    String authtoken = await FirebaseAuth.instance.currentUser!.getIdToken();
    // RemoteService().addOrder(authtoken);
    order_details = await RemoteService().getOrders(authtoken);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ListView.builder(
                      // padding:
                      //     EdgeInsets.only(top: 15, left: 15, right: 15),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: order_details.vendors.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding:
                              EdgeInsets.only(bottom: 5, right: 5, left: 5),
                          height: 190 +
                              (order_details.vendors[index].orderDescription
                                          .length -
                                      1) *
                                  85,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 190, 190, 190),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Row(
                                  children: [
                                    Text(order_details.vendors[index].status),
                                    Spacer(),
                                    Text(
                                      DateFormat().format(order_details
                                          .vendors[index].createdAt),
                                      style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Text(
                                  "Total Cost: " +
                                      order_details.vendors[index].cost
                                          .toString() +
                                      "₹",
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    height: 25,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          order_details.vendors[index].vendorId,
                                          style: GoogleFonts.openSans(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: order_details.vendors[index]
                                          .orderDescription.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            height: 80,
                                            child: Row(
                                              children: [
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  elevation: 0,
                                                  child: Container(
                                                    height: 80,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "cart.get_item(index).image"),
                                                          fit: BoxFit.fill,
                                                        )),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      120,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Spacer(),
                                                      Text(
                                                        order_details
                                                            .vendors[index]
                                                            .orderDescription[0]
                                                            .id,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      // Spacer(),
                                                      // Text(
                                                      //   "Cost: " +
                                                      //       order_details
                                                      //           .vendors[index]
                                                      //           .cost
                                                      //           .toString() +
                                                      //       "₹",
                                                      //   style:
                                                      //       GoogleFonts.openSans(
                                                      //     fontSize: 12,
                                                      //     fontWeight:
                                                      //         FontWeight.w500,
                                                      //     color: Colors.black,
                                                      //   ),
                                                      // ),
                                                      // Spacer(),
                                                      Text(
                                                        "Quantity: " +
                                                            order_details
                                                                .vendors[index]
                                                                .orderDescription[
                                                                    index]
                                                                .quantity
                                                                .toString(),
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      // Spacer(),
                                                      Text(
                                                        "Instruction: " +
                                                            order_details
                                                                .vendors[index]
                                                                .buyerMessage,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     setState(() {
                                                //       if (cart.contains(
                                                //           cart.get_item(index))) {
                                                //         cart.remove(
                                                //             cart.get_item(index));
                                                //       } else {
                                                //         cart.add_item(
                                                //             cart.get_item(index));
                                                //       }
                                                //     });
                                                //   },
                                                //   child: Icon(
                                                //     cart.contains(
                                                //             cart.get_item(index))
                                                //         ? Icons.remove_circle
                                                //         : Icons.remove_circle,
                                                //     color: cart.contains(
                                                //             cart.get_item(index))
                                                //         ? Colors.white
                                                //         : null,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
