import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/services/local_save.dart';
import 'package:frontend/screens/HomePage/home_page_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/Auth/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/models/app_state.dart';
import 'package:frontend/reducers/app_state_reducer.dart';
import 'package:frontend/screens/HomePage/home_page_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'utils/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/Auth/sign_in_screen.dart';
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
      title: 'Upcycle',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        primaryColor: Colors.white,
        brightness: Brightness.dark,
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final Future<String?> _username = localGet('username');

  @override
  Widget build(BuildContext context){
    return FutureBuilder<String?>(
        future: _username,
        builder: (context, snapshot) {
            if (snapshot.data != null) {
              return const HomePageScreen();
            } else {
              return SignInScreen();
            }
        });
  }
}
