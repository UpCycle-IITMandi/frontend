import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/shared/local_save.dart';
import 'package:frontend/shared/sign_in_button.dart';
import 'package:frontend/screens/sign_up_screen.dart';
import 'package:frontend/utils/authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';


import '../services/remote_service.dart';

class CenterHorizontal extends StatelessWidget {
  CenterHorizontal({required this.child});
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
        child: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          spacing: 5,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'UpCycle',
                style: TextStyle(
                  color: Colors.orange.shade400,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Center(
                child: SignInButton(onPressed: () async {
                  await Authentication.signOut(context: context);

                  final GoogleSignInAccount? googleSignInAccount =
                      await Authentication.signInWithGoogle(context: context);

                  String? user_token = googleSignInAccount?.id;
                  String user_email = googleSignInAccount?.email ?? "No email";

                  if (!mounted || user_token == null) return;

                  if (!user_email.endsWith("iitmandi.ac.in")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please use Institute email')),
                    );
                  }

                  else {
                    Response res = await RemoteService().getUser(user_token);
                    print(res.body);
                    var user = json.decode(res.body);
                    bool userExists = user["userExists"];

                    if (!userExists) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SignUpScreen())));
                    }

                    else{
                      localSave("username", user["name"]);
                      localSave("email", user_email);
                      localSave("token", user_token);
                      localSave("campus", user["campus"]);
                      return MyApp;
                    }
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
