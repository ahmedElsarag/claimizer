import 'package:flutter/cupertino.dart';

ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));

class Const {
  static const String CURRENT_USER_KEY = 'CURRENT_USER_KEY';

  static const String USER_NAME = 'USER_NAME';

  static const String LOCALE_LANG = 'LOCALE_LANG';

  static const String USER_IMAGE = 'USER_IMAGE';

  static const String IS_LOGIN_KEY = "is_logged_in";

  static const String IS_Arabic_KEY = "is_arabic_in";

  static const String IS_NOTIFICATION_ENABLED = "IS_NOTIFICATION_ENABLED";

  static const String USER_TOKEN = "USER_TOKEN";

  static const String USER_ID = "USER_ID";

  static const String APP_LOCAL = "APP_LOCAL";

  static const String AVAILABLE_TEACHER = "AVAILABLE_TEACHER";

  static const String SOURCE_FORGET_PASSWORD = "FORGET";

  static const String SOURCE_REGISTER = "Register";

  static const String SOURCE_LOGIN = "LOGIN";

  static const String SOURCE_HOME = "HOME";

  static const THEME_STATUS = "THEMESTATUS";
}

enum FileType { products, posts, reviews, comments }
