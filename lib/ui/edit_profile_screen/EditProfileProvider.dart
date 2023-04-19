import 'package:Cliamizer/base/provider/base_provider.dart';
import 'package:Cliamizer/network/models/ProfileResponse.dart';
import 'package:flutter/material.dart';

class EditProfileProvider<T> extends BaseProvider<T> {
  bool _obscureTextPassword = true;
  bool _isDateLoaded = false;
  bool _internetStatus = true;
  TextEditingController nameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController mobileController = TextEditingController();
  ProfileResponse _profileData;
  int _selectedTabIndex = 0;
  int _isNotificationEnabled;


  int get isNotificationEnabled => _isNotificationEnabled;

  set isNotificationEnabled(int value) {
    _isNotificationEnabled = value;
    notifyListeners();
  }

  bool get obscureTextPassword => _obscureTextPassword;

  set obscureTextPassword(bool value) {
    _obscureTextPassword = value;
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  ProfileResponse get profileData => _profileData;

  set profileData(ProfileResponse value) {
    _profileData = value;
    notifyListeners();
  }

  int get selectedTabIndex => _selectedTabIndex;

  set selectedTabIndex(int value) {
    _selectedTabIndex = value;
    notifyListeners();
  }
}
