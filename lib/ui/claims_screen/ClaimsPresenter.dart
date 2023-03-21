import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/claims_response.dart';
import 'package:dio/dio.dart';

import '../../CommonUtils/preference/Prefs.dart';
import '../../network/api/network_api.dart';
import '../../network/network_util.dart';
import 'claims_screen.dart';

class ClaimsPresenter extends BasePresenter<ClaimsScreenState> {
  Future getAllClaimsApiCall() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimsResponse>(Method.get, options: Options(headers: header), endPoint: Api.claimsApiCall,
        onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.provider.claimsList = data.data;
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }
}
