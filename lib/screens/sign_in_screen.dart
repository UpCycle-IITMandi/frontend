import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.indigo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'UpCycle',
            style: TextStyle(
              color: Colors.orange.shade400,
              fontSize: 20,
            ),
          ),
          SignInButton(onPressed: () {
            var googleProvider = GoogleAuthProvider();
            googleProvider
                .addScope('https://www.googleapis.com/auth/contacts.readonly');
            googleProvider
                .setCustomParameters({'login_hint': 'user@example.com'});

            FirebaseAuth.instance
                .signInWithAuthProvider(googleProvider)
                .then((value) => print(value));
          }),
        ],
      ),
    );
  }
}
