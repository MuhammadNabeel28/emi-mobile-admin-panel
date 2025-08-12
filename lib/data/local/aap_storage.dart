import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class LocalStorage {
  static late SharedPreferences _preferences;
  static final Logger logger = Logger();

  static const String isLoginNew = 'isLoginNewKey';
  static const String userLoginKey = 'UserLoginKey';
  static const String userNameKey = 'UserNameKey';
  static const String refreshTokenKey = 'refreshTokenKey';
  static const String accessTokenKey = 'accessTokenKey';
  static const String rememberKey = 'rememberKey';
  static const String userIdKey = 'userIdKey';
  static const String passwordKey = 'passwordKey';
  static const String launchFirstKey = 'launchFirstKey';
  static const String isLoginKey = 'isLoginKey';
  static const String deviceIdKey = 'deviceIdKey';
  

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //! Set a String value
  static Future<void> setString(String key, String value) async {
    try {
      if (key.isEmpty) {
        logger.w("Key cannot be empty");
        throw Exception("Key cannot be empty");
      } else {
        await _preferences.setString(key, value);
        logger.i("(Local Stotrage Class) : Set String: $key = $value");
      }
    } catch (e) {
      logger.e("(Local Stotrage Class) : Error setting string: $e");
      throw Exception("Error setting string: $e");
    }
  }

  //! Get a String value
  static String? getString(String key) {
    try {
      if (key.isEmpty) {
        logger.w("Key cannot be empty");
        throw Exception("Key cannot be empty");
      } else {
        final value = _preferences.getString(key);
        logger.i("(Local Stotrage Class) : Get String: $key = $value");
        return value;
      }
    } catch (e) {
      logger.e("(Local Stotrage Class) : Error getting string: $e");
      throw Exception("Error getting string: $e");
    }
  }

  //! Set a bool value
  static Future<void> setbool(String key, bool value) async {
    await _preferences.setBool(key, value);
    logger.i("(Local Storage Class) : Set Remember Password: $key = $value");
  }

  //! Get a bool value
  static bool? getbool(String key) {
    return _preferences.getBool(key);
  }
}
