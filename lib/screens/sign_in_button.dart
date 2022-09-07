import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key, required this.onPressed}) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Image(
          image: AssetImage("assets/images/google.png"),
          color: null,
          height: 20,
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white, onPrimary: Colors.black),
        label: const Text("Sign in with Google"));
  }
}
