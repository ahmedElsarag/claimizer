import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/NotificationResponse.dart';
import 'package:dio/dio.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../network/api/network_api.dart';
import '../../network/network_util.dart';
import 'NotificationScreen.dart';


class NotificationPresenter extends BasePresenter<NotificationScreenState> {

  Future getNotificationApiCall() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<NotificationResponse>(Method.get,
        options: Options(headers: header), endPoint: Api.getNotificationApiCall, onSuccess: (data) {
          view.closeProgress();
          if (data != null) {
            view.provider.notificationList = data.data;
          }
        }, onError: (code, msg) {
          view.closeProgress();
        });
  }

}
