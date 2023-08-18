import 'package:Cliamizer/CommonUtils/preference/Prefs.dart';
import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/ui/home_screen/HomeScreen.dart';
import 'package:dio/dio.dart';

import '../../network/api/network_api.dart';
import '../../network/models/StatisticsResponse.dart';
import '../../network/network_util.dart';

class HomePresenter extends BasePresenter<HomeScreenState> {
  void getUserName() async {
    await Prefs.getUserName.then((value) {
      view.provider.name = value;
    });
  }

  void getUserImage() async {
    await Prefs.getUserImage.then((value) {
      view.provider.avatar = value;
    });
  }

  Future getStatisticsApiCall({bool isUpdateData = false}) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    if (!isUpdateData) view.showProgress(isDismiss: false);
    await requestFutureData<StatisticsResponse>(Method.get,
        options: Options(headers: header), endPoint: Api.statisticsApiCall, onSuccess: (data) {
      if (!isUpdateData) view.closeProgress();
      if (data != null) {
        print('~~~~~~~~~~~~~updated');
        view.provider.claimsStatistics.clear();
        view.provider.rememberThatList = data.data.aboutToExpireUnits;
        view.provider.claimStatusColors = data.data.claimColor;
        view.provider.claimsStatistics.add(data.data.claims.all.toString());
        view.provider.claimsStatistics.add(data.data.claims.newClaims.toString());
        view.provider.claimsStatistics.add(data.data.claims.assigned.toString());
        view.provider.claimsStatistics.add(data.data.claims.inProgress.toString());
        view.provider.claimsStatistics.add(data.data.claims.completed.toString());
        view.provider.claimsStatistics.add(data.data.claims.cancelled.toString());
        view.provider.claimsStatistics.add(data.data.claims.closed.toString());
      }
    }, onError: (code, msg) {
      view.closeProgress();
      if (code == 401) {
        return "error";
      }
    });
  }

  List<String> statusList = [
    'all',
    'new',
    'assigned',
    'inProgress',
    'completed',
    'cancelled',
    'closed',
  ];
}
