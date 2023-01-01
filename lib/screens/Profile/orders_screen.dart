import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/config/constants.dart';
import 'package:frontend/models/orders.dart';
import 'package:frontend/services/remote_service.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrderLoad orderDetails;

  Future<bool> getData() async {
    orderDetails = await RemoteService().getOrders();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: orderDetails.orders.length,
                      itemBuilder: (context, index) {
                        final order = orderDetails.orders[index];
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.vendorId,
                                        style: const TextStyle(
                                          color: Constants.grey3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(DateFormat().format(order.createdAt),
                                          style: const TextStyle(
                                            color: Constants.grey3,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Text(
                                        "Total: ${order.cost}",
                                        style: const TextStyle(
                                          color: Constants.grey3,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Text(
                                        "Chilli Potato, Chilli Chicken, Mushroom-do-pyaaza ...  more",
                                        style: TextStyle(
                                          color: Constants.grey3,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  StatusButton(
                                    status: order.status,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Text("Error");
              }
            }),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final String status;
  const StatusButton({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (status == "pending"
            ? const Color(0xFFEDED52)
            : status == "accepted"
                ? Constants.green1
                : const Color(0xFFE43B4F)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Text(
        "Status: ${status.toUpperCase()}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
