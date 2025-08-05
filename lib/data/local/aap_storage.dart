import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class LocalStorage {
  static late SharedPreferences _preferences;
  static final Logger logger = Logger();

  static const String isLoginNew = 'isLoginNewKey';
  static const String userLoginKey = 'UserLoginKey';
  static const String userNameKey = 'UserNameKey';

   static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }


}