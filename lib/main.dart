import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/reducers/app_state_reducer.dart';
import 'package:frontend/screens/home_page_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/sign_in_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
  );
  runApp(StoreProvider<AppState>(
    store: store,
    child: MaterialApp(
      home: MyApp(store: store),
      title: 'FlutterFire Samples',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.dark,
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  @override
  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
            ));
          } else if (snapshot.hasData) {
            return HomePageScreen();
          } else {
            return SignInScreen();
          }
        });
  }
}
