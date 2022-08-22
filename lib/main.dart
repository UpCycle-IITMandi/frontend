import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/sign_in_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MyApp(),
    title: 'FlutterFire Samples',
    debugShowCheckedModeBanner: true,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      brightness: Brightness.dark,
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SignInScreen();
              }
            }));
  }
}
