import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String userData = 'userData';

  Future<void> setUserData(String userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.userData, userData);
  }

//get value from shared preferences
  Future<Object> getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Object userData;
    userData = pref.getString(this.userData) ?? null;
    return userData;
  }
}
