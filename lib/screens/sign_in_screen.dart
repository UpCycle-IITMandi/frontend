import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            children: [
              Text(
                'UpCycle',
                style: TextStyle(
                  color: Colors.orange.shade400,
                  fontSize: 20,
                ),
              ),
              SignInButton(Buttons.Google, onPressed: () {
                var googleProvider = GoogleAuthProvider();
                googleProvider.addScope(
                    'https://www.googleapis.com/auth/contacts.readonly');
                googleProvider
                    .setCustomParameters({'login_hint': 'user@example.com'});

                FirebaseAuth.instance
                    .signInWithAuthProvider(googleProvider)
                    .then((value) => print(value));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
