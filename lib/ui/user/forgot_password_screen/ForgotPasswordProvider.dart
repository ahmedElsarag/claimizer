import 'package:flutter/cupertino.dart';
import 'package:Cliamizer/base/provider/base_provider.dart';

class ForgotPasswordProvider<T> extends BaseProvider<T> {
  String _language;
  bool _isRememberMe =false;

  bool get isRememberMe => _isRememberMe;

  set isRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }

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
