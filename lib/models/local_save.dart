import 'package:frontend/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> localSave(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key,value);
}

Future<void> saveUser(String name, String email, String upiID, String campus, String hostel) async {
  final prefs = await SharedPreferences.getInstance();
  localSave("username", name);
  localSave("email", email);
  localSave("upi", upiID);
  localSave("campus", campus);
  localSave("hostel", hostel);
}

Future<void> localDelete(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<void> deleteUser() async {
  final prefs = await SharedPreferences.getInstance();
  localDelete("username");
  localDelete("email");
  localDelete("upi");
  localDelete("campus");
  localDelete("hostel");
}