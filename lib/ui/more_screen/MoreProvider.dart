import 'package:Cliamizer/base/provider/base_provider.dart';

class MoreProvider<T> extends BaseProvider<T> {
  bool _receiveNotification = true;

  bool get receiveNotification => _receiveNotification;

  set receiveNotification(bool value) {
    _receiveNotification = value;
    notifyListeners();
  }

}
