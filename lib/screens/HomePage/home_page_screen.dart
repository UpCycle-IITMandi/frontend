import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/models/app_state.dart';
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
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
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
        title: const Text('App',
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
        selectedItemColor: const Color.fromARGB(255, 223, 73, 73),
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
      animationType: BadgeAnimationType.slide,
      badgeContent: StoreConnector<AppState, String>(
        converter: (store) => store.state.cartItems.length.toString(),
        builder: ((context, vm) {
          print("length ");
          print(vm);
          return Text(vm, style: const TextStyle(color: Colors.white));
        }),
      ),
      child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          tooltip: 'Open shopping cart',
          onPressed: () {}),
    );
  }
}
