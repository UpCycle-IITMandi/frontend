import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:frontend/screens/my_account.dart';
=======
import 'package:frontend/screens/profile/my_account.dart';
import 'package:frontend/services/local_save.dart';
import 'package:frontend/screens/Auth/sign_in_screen.dart';
>>>>>>> Stashed changes
import 'package:frontend/screens/Vendors/vendor_list_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/screens/Cart/cart_screen.dart';
import 'package:frontend/screens/Vendors/vendor_list_screen.dart';
import 'package:frontend/utils/authentication.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    VendorList(),
    myAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var primaryColorSelector = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryColorSelector,
      appBar: AppBar(
        actions: const [
          CartAppBarWidget(),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Upcycle',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: primaryColorSelector,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        backgroundColor: primaryColorSelector,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(5, 40, 5, 40),
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Authentication.signOut(context: context);
<<<<<<< Updated upstream
=======
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context) => SignInScreen())),
                    (route) => false);
              },
            ),
            ListTile(
              title: const Text(
                'Print userDetails in console',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                var user = await getUser();
                print(user);
>>>>>>> Stashed changes
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColorSelector,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent.shade200,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
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
                MaterialPageRoute(builder: ((context) => CartScreen())));
          }),
    );
  }
}
