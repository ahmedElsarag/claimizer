import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {

  final String _selectedLanguageKey = 'selected_language';
  Locale _locale = Locale('en');

  LanguageProvider() {
    loadSelectedLanguage();
  }
  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLanguageKey, locale.languageCode);
  }

  void loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_selectedLanguageKey);
    if (languageCode != null) {
      _locale = Locale(languageCode);
    }
  }
}