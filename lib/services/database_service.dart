import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  Future<bool> setString(String key, String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (await sharedPreferences.setString(key, value)) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getString(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key)) {
      return sharedPreferences.getString(key);
    } else {
      return '999999999999999999';
    }
  }
}
