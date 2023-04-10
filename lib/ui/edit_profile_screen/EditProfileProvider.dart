import 'package:Cliamizer/base/provider/base_provider.dart';
import 'package:Cliamizer/network/models/ProfileResponse.dart';
import 'package:flutter/material.dart';

class EditProfileProvider<T> extends BaseProvider<T> {
  bool _obscureTextPassword = true;

  bool get obscureTextPassword => _obscureTextPassword;

  set obscureTextPassword(bool value) {
    _obscureTextPassword = value;
    notifyListeners();
  }

  int _selectedValue = 1;

  int get selectedValue => _selectedValue;

  set selectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isDateLoaded = false;
  bool _internetStatus = true;
  String name, email,mobile;

  bool get internetStatus => _internetStatus;

  set internetStatus(bool value) {
    _internetStatus = value;
    notifyListeners();
  }

  bool get isDateLoaded => _isDateLoaded;

  set isDateLoaded(bool value) {
    _isDateLoaded = value;
    notifyListeners();
  }

  ProfileResponse _profileData;

  ProfileResponse get profileData => _profileData;

  set profileData(ProfileResponse value) {
    _profileData = value;
    notifyListeners();
  }

  int _selectedTabIndex = 0;

  int get selectedTabIndex => _selectedTabIndex;

  set selectedTabIndex(int value) {
    _selectedTabIndex = value;
    notifyListeners();
  }
}
