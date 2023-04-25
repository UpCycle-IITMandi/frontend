import 'package:badges/badges.dart' as BadgesModule;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/config/constants.dart';
import 'package:frontend/screens/Vendors/vendor_list_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/screens/Cart/cart_screen.dart';
import 'package:frontend/screens/Profile/my_account.dart';
import 'package:frontend/services/local_save.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController searchController = TextEditingController();
  late String campus;
  late String roomNo;

  Future<bool> getData() async {
    campus = await localGet("campus") ?? "none";
    roomNo = await localGet("roomNo") ?? "B-17, 209";
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 50,
              color: Constants.green1,
            ),
            const SizedBox(
              width: 5,
            ),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(campus.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        Text(roomNo,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Constants.grey3)),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
        actions: [
          // CartAppBarWidget(),
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyAccount(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.cyan[900],
                foregroundImage: NetworkImage(FirebaseAuth
                        .instance.currentUser!.photoURL ??
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        // title: const Text('Village Square',
        //     style: TextStyle(
        //       color: Colors.black,
        //     )),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 35,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.grey4,
              ),
              child: Stack(
                children: <Widget>[
                  TextField(
                    cursorColor: Constants.grey3,
                    controller: searchController,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 7, bottom: 3),
                      border: InputBorder.none,
                      hintText: 'Search for restaurant..',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Constants.grey3,
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: Icon(
                        Icons.search_outlined,
                        color: Constants.grey3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(child: VendorList()),
          ],
        ),
      ),
    );
  }
}

class CartAppBarWidget extends StatelessWidget {
  const CartAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BadgesModule.Badge(
      position: BadgesModule.BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: const Duration(milliseconds: 300),
      animationType: BadgesModule.BadgeAnimationType.scale,
      badgeColor: Colors.orangeAccent.shade200,
      badgeContent: StoreConnector<AppState, String>(
        converter: (store) => store.state.cartItems.length.toString(),
        builder: ((context, vm) {
          return Text(vm,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold));
        }),
      ),
      child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          tooltip: 'Open shopping cart',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const CartScreen())));
          }),
    );
  }
}
