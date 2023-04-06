import 'package:Cliamizer/base/provider/base_provider.dart';

class MoreProvider<T> extends BaseProvider<T> {
  bool _receiveNotification = true;

  bool get receiveNotification => _receiveNotification;

  set receiveNotification(bool value) {
    _receiveNotification = value;
    notifyListeners();
  }


  bool _isDateLoaded = false;
  bool _internetStatus = true;


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

}
