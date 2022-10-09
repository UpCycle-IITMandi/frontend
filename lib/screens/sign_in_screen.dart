import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/shared/sign_in_button.dart';
import 'package:frontend/screens/sign_up_screen.dart';
import 'package:frontend/utils/authentication.dart';

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
                  User? user =
                      await Authentication.signInWithGoogle(context: context);

                  if (!mounted) return;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SignUpScreen())));

                  // var googleProvider = GoogleAuthProvider();
                  // googleProvider.addScope(
                  //     'https://www.googleapis.com/auth/contacts.readonly');
                  // googleProvider
                  //     .setCustomParameters({'login_hint': 'user@example.com'})
                  // FirebaseAuth.instance
                  //     .signInWithAuthProvider(googleProvider)
                  //     .then((value) => print(value));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
