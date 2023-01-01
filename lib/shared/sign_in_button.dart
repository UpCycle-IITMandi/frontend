import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key, required this.onPressed}) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Image(
            image: AssetImage("assets/images/google.png"),
            color: null,
            height: 20,
          ),
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ), backgroundColor: const Color(0xFF77DD77)),
          label: const Text(
            "Sign in with Google",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )),
    );
  }
}
