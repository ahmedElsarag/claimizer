import 'package:Cliamizer/base/provider/base_provider.dart';

class ClaimsProvider<T> extends BaseProvider<T> {
  int _selectedIndex = 1;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  int _currentStep = 0;

  int get currentStep => _currentStep;

  set currentStep(int value) {
    _currentStep = value;
    notifyListeners();
  }
  int _selectedUnitIndex = 0;

  int get selectedUnitIndex => _selectedUnitIndex;

  set selectedUnitIndex(int value) {
    _selectedUnitIndex = value;
    notifyListeners();
  }
}
