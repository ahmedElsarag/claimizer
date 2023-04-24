import 'package:Cliamizer/base/provider/base_provider.dart';
import 'package:Cliamizer/network/models/NotificationResponse.dart';

class NotificationProvider<T> extends BaseProvider<T> {
  bool _receiveNotification = true;

  bool get receiveNotification => _receiveNotification;

  set receiveNotification(bool value) {
    _receiveNotification = value;
    notifyListeners();
  }

  List<NotificationDataBean> _notificationList = [];

  List<NotificationDataBean> get notificationList => _notificationList;

  set notificationList(List<NotificationDataBean> value) {
    _notificationList = value;
    notifyListeners();
  }

}
