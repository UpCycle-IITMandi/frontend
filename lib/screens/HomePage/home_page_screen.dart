import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/Vendors/vendor_list_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/screens/Cart/cart_screen.dart';
import 'package:frontend/screens/profile/my_account.dart';
import 'package:frontend/services/local_save.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController searchController = TextEditingController();

  // int _selectedIndex = 0;

  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   VendorList(),
  //   myAccount(),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  late String campus;
  late String roomNo;

  Future<bool> getData() async {
    campus = await localGet("campus") ?? "none";
    roomNo = await localGet("roomNo") ?? "B-17, 209";
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var primaryColorSelector = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryColorSelector,
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 50,
              color: Color(0xFF77DD77),
            ),
            const SizedBox(
              width: 10,
            ),
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(campus,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(roomNo,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5F5F5F))),
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
                    builder: (context) => const myAccount(),
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
        // title: const Text('Upcycle',
        //     style: TextStyle(
        //       color: Colors.black,
        //     )),
        elevation: 0,
        backgroundColor: primaryColorSelector,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 35,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF5F5F5),
              ),
              child: Stack(
                children: <Widget>[
                  TextField(
                    controller: searchController,
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 10, right: 50, bottom: 15),
                        border: InputBorder.none,
                        hintText: 'Search for restaurant..',
                        hintStyle: GoogleFonts.openSans(
                          fontSize: 13,
                          color: const Color(0xFF5F5F5F),
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  const Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.search_outlined,
                      color: Color(0xFF5F5F5F),
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
      // drawer: Drawer(
      //   backgroundColor: primaryColorSelector,
      //   child: ListView(
      //     padding: const EdgeInsets.fromLTRB(5, 40, 5, 40),
      //     children: [
      //       ListTile(
      //         title: const Text(
      //           'Logout',
      //           style: TextStyle(
      //             color: Colors.black,
      //           ),
      //         ),
      //         onTap: () {
      //           Authentication.signOut(context: context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: primaryColorSelector,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.orangeAccent.shade200,
      //   unselectedItemColor: Colors.black,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

class CartAppBarWidget extends StatelessWidget {
  const CartAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: const Duration(milliseconds: 300),
      animationType: BadgeAnimationType.scale,
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
