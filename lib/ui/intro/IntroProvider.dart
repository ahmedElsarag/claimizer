import '../../CommonUtils/preference/Prefs.dart';
import '../../base/provider/base_provider.dart';

class IntroProvider extends BaseProvider {
  Future<void> isUserLoggedIn(context) async {
    if (Prefs.getUserToken != null ||
        Prefs.getUserToken.toString().isNotEmpty) {
    } else
    notifyListeners();
  }
}
