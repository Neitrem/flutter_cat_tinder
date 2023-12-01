import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  Future<Map<String, dynamic>?> getSavedData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? login = prefs.getString('login');
      final String? password = prefs.getString('password');
      
      return {
        "login": login,
        "password": password
      };
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
