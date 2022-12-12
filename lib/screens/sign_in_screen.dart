import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/HomePage/home_page_screen.dart';
import 'package:frontend/screens/sign_up_screen.dart';
import 'package:frontend/services/local_save.dart';
import 'package:frontend/shared/sign_in_button.dart';
import 'package:frontend/utils/authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import '../../services/remote_service.dart';

class CenterHorizontal extends StatelessWidget {
  const CenterHorizontal({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [child]);
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.14),
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: const AssetImage("assets/images/logo.png"),
                color: null,
                height: MediaQuery.of(context).size.height * 0.14,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: const AssetImage("assets/images/Vector.png"),
                color: null,
                height: MediaQuery.of(context).size.height * 0.45,
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.12),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Center(
                child: SignInButton(onPressed: () async {
                  await Authentication.signOut(context: context);
                  final GoogleSignInAccount? googleSignInAccount =
                      await Authentication.signInWithGoogle(context: context);
                  FirebaseAuth auth = FirebaseAuth.instance;
                  String? authToken = await auth.currentUser?.getIdToken();

                  String userEmail = googleSignInAccount?.email ?? "No email";

                  if (!mounted ||
                      authToken == null ||
                      googleSignInAccount == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please use Institute email')),
                    );
                    return;
                  }

                  Response res =
                      await RemoteService().getUser(authToken, userEmail);
                  print(res.body);
                  var user = json.decode(res.body);
                  bool userExists = user["userExists"];

                  if (!userExists) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SignUpScreen())));
                  } else {
                    user = user["user"];
                    saveUser(
                        user["firstName"] + ' ' + user["lastName"],
                        userEmail,
                        user["upiId"],
                        user["campus"],
                        user["hostel"],
                        user["profilePicture"]);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomePageScreen())),
                        (route) => false);
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
