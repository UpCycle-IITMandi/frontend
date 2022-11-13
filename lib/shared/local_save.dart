import 'package:shared_preferences/shared_preferences.dart';

Future<void> localSave(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
<<<<<<< Updated upstream
  prefs.setString(key,value);
}
=======
  prefs.setString(key, value);
}
>>>>>>> Stashed changes
