
import '../../CommonUtils/preference/Prefs.dart';
import '../../base/provider/base_provider.dart';

class SplashProvider extends BaseProvider {
  Future<void> isUserLoggedIn(context) async {
    if (Prefs.getUserToken != null ||
        Prefs.getUserToken.toString().isNotEmpty) {
    } else
    notifyListeners();
  }

  String _language;
  String get language => _language;

  set language(String value) {
    _language = value;
    notifyListeners();
  }
}
