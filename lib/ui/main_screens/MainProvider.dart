import 'package:flutter/material.dart';

import '../../base/provider/base_provider.dart';

class MainProvider<T> extends BaseProvider<T> {
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  set isUserLoggedIn(bool value) {
    _isUserLoggedIn = value;
    notifyListeners();
  }

  DateTime _lastPressedAt;

  DateTime get lastPressedAt => _lastPressedAt;

  set lastPressedAt(DateTime value) {
    _lastPressedAt = value;
    notifyListeners();
  }

  int _currentSelect = 0;

  int get currentSelect => _currentSelect;

  set currentSelect(int value) {
    _currentSelect = value;
    notifyListeners();
  }


  PageController _pageController = PageController();

  PageController get pageController => _pageController;

  set pageController(PageController value) {
    _pageController = value;
    notifyListeners();
  }
}
