import 'Const.dart';
import 'helper.dart';

class Prefs {
  static Future<bool> get isLogin =>
      PreferencesHelper.getBool(Const.IS_LOGIN_KEY);

  static Future setIsLogin(bool value) =>
      PreferencesHelper.setBool(Const.IS_LOGIN_KEY, value);

  static Future<bool> get getIsArabicLang =>
      PreferencesHelper.getBool(Const.IS_Arabic_KEY);

  static Future setIsArabicLang(bool value) =>
      PreferencesHelper.setBool(Const.IS_Arabic_KEY, value);

  static Future<bool> get isNotificationEnabled =>
      PreferencesHelper.getBool(Const.IS_NOTIFICATION_ENABLED);

  static Future setIsNotificationEnabled(bool value) =>
      PreferencesHelper.setBool(Const.IS_NOTIFICATION_ENABLED, value);

  static Future setUserToken(String value) =>
      PreferencesHelper.setString(Const.USER_TOKEN, value);

  static Future<String> get getUserToken =>
      PreferencesHelper.getString(Const.USER_TOKEN);

  static Future setUserImage(String value) =>
      PreferencesHelper.setString(Const.USER_IMAGE, value);

  static Future<String> get getUserImage =>
      PreferencesHelper.getString(Const.USER_IMAGE);

  static Future setLocaleLang(String value) =>
      PreferencesHelper.setString(Const.LOCALE_LANG, value);

  static Future<String> get getLocaleLang =>
      PreferencesHelper.getString(Const.LOCALE_LANG);

  static Future setUserId(String value) =>
      PreferencesHelper.setString(Const.USER_ID, value);

  static Future<String> get getUserId =>
      PreferencesHelper.getString(Const.USER_ID);

  static Future setCurrentUser(String value) =>
      PreferencesHelper.setString(Const.CURRENT_USER_KEY, value);

  static Future<String> get getCurrentUser =>
      PreferencesHelper.getString(Const.CURRENT_USER_KEY);

  static Future setUserName(String value) =>
      PreferencesHelper.setString(Const.USER_NAME, value);

  static Future<String> get getUserName =>
      PreferencesHelper.getString(Const.USER_NAME);

  static Future setTeacherAvailable(bool value) =>
      PreferencesHelper.setBool(Const.AVAILABLE_TEACHER, value);

  static Future<bool> get getTeacherAvailable =>
      PreferencesHelper.getBool(Const.AVAILABLE_TEACHER);

  static Future setAppLocal(String value) =>
      PreferencesHelper.setString(Const.APP_LOCAL, value);

  static Future<String> get getAppLocal =>
      PreferencesHelper.getString(Const.APP_LOCAL);


  static Future<void> clear() async {
    PreferencesHelper.clearPrefs();
  }

  static Future<void> clearExpectLanguage() async {
    getAppLocal.then((value) => {
          PreferencesHelper.clearPrefs(),
          setAppLocal(value),
        });
  }
}
