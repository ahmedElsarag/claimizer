import 'package:flutter/cupertino.dart';
import 'package:Cliamizer/base/provider/base_provider.dart';

class LoginProvider<T> extends BaseProvider<T> {

  bool _isRememberMe = false;
  bool _obscureTextPassword = true;

  bool get obscureTextPassword => _obscureTextPassword;

  set obscureTextPassword(bool value) {
    _obscureTextPassword = value;
    notifyListeners();
  }

  bool get isRememberMe => _isRememberMe;

  set isRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }
  String _language;
  String get language => _language;

  set language(String value) {
    _language = value;
    notifyListeners();
  }

  double _logoOpacity = .5;

  AlignmentGeometry _alignmentGeometry;

  AlignmentGeometry get alignmentGeometry => _alignmentGeometry;

  set alignmentGeometry(AlignmentGeometry value) {
    _alignmentGeometry = value;
    notifyListeners();
  }

  double get logoOpacity => _logoOpacity;

  set logoOpacity(double value) {
    _logoOpacity = value;
    notifyListeners();
  }

  double opacity = 0;
  String errorMessage = '';

  void setError(String value) {
    errorMessage = value;
    opacity = 1;
    notifyListeners();
  }

  void clearError() {
    errorMessage = '';
    opacity = 0;
    notifyListeners();
  }
}
