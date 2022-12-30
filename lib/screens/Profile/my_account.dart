import 'package:flutter/material.dart';
import 'package:frontend/config/constants.dart';
import 'package:frontend/screens/Profile/edit_profile.dart';
import 'package:frontend/screens/Profile/orders_screen.dart';
import 'package:frontend/services/local_save.dart';
import 'package:frontend/utils/authentication.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late String username;
  late String email;
  late String photoUrl;

  Future<bool> getData() async {
    username = await localGet("username") ?? "none";
    email = await localGet("email") ?? "none";
    photoUrl = await localGet("photoUrl") ?? "";
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title:
            const Text('Village Square', style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 76,
                                    backgroundColor: Constants.green1,
                                    child: CircleAvatar(
                                      radius: 72,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 69,
                                        backgroundImage: NetworkImage(photoUrl),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              username,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditProfile()));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Constants.green1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 0, right: 0, bottom: 10, top: 5),
                    width: 150,
                    height: 30,
                    child: const Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Constants.grey3,
                  height: 1,
                ),
                ListItem(
                    name: "Settings",
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onTap: () {}),
                ListItem(
                    name: "Previous Orders",
                    icon: const Icon(
                      Icons.fast_rewind,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OrdersScreen()));
                    }),
                const Divider(
                  color: Constants.grey3,
                  height: 1,
                ),
                ListItem(
                    name: "About Us",
                    icon: const Icon(Icons.info, color: Colors.white),
                    onTap: () {}),
                ListItem(
                    name: "Logout",
                    icon: const Icon(Icons.logout_rounded, color: Colors.white),
                    onTap: () {
                      Authentication.signOut(context: context)
                          .then((value) => Navigator.of(context).pop());
                    }),
              ]),
        ),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  final Icon icon;
  final String name;
  final void Function() onTap;
  const ListItem(
      {super.key, required this.name, required this.icon, required this.onTap});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        alignment: Alignment.center,
        child: CircleAvatar(
          backgroundColor: Constants.green1,
          child: widget.icon,
        ),
      ),
      trailing: Container(
        width: 20,
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Constants.grey3,
          size: 20,
        ),
      ),
      title: Text(
        widget.name,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      dense: false,
    );
  }
}
