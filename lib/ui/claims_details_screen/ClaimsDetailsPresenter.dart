import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/ClaimDetailsResponse.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../app_widgets/LoginRequiredDialog.dart';
import '../../generated/l10n.dart';
import '../../network/api/network_api.dart';
import '../../network/exception/error_status.dart';
import '../../network/network_util.dart';
import 'ClaimsDetailsScreen.dart';


class ClaimsDetailsPresenter extends BasePresenter<ClaimsDetailsScreenState> {
  getClaimDetailsDataApiCall(String id) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token)  {
      view.showProgress(isDismiss: false);
      header['Authorization'] = "Bearer $token";
      requestFutureData<ClaimDetailsResponse>(
        Method.get,
        endPoint: Api.getClaimDetailsApiCall(id),
        options: Options(headers: header),
        onSuccess: (data)  {
          Log.d("${data.data.id}");
          if (data != null) {
            view.provider.setData(data.data);
            view.provider.isDateLoaded = true;
            view.closeProgress();
          }else{
            view.closeProgress();
          }
        },
        onError: (code, msg) {
          Log.d(msg);
          if(code == ErrorStatus.UNKNOWN_ERROR)
            view.provider.internetStatus = false;
          view.closeProgress();
          if(code == ErrorStatus.UNAUTHORIZED)
            showDialog( context: view.context,builder: (_)=>
                LoginRequiredDialog( message: S.of(view.context).sessionTimeoutPleaseLogin),barrierDismissible: false);
        },
      );
    });
  }
}
