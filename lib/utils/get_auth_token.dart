import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getAuthToken() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? authToken = await auth.currentUser?.getIdToken();
  return authToken;
}
