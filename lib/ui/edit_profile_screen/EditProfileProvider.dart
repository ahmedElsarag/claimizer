import 'package:Cliamizer/base/provider/base_provider.dart';

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
}
