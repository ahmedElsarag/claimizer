import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../app_widgets/LoginRequiredDialog.dart';
import '../../generated/l10n.dart';
import '../../network/api/network_api.dart';
import '../../network/exception/error_status.dart';
import '../../network/models/ProfileResponse.dart';
import '../../network/network_util.dart';
import 'MoreScreen.dart';

class MorePresenter extends BasePresenter<MoreScreenState> {

  getProfileData() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token)  {
      view.showProgress(isDismiss: false);
      header['Authorization'] = "Bearer $token";
      requestFutureData<ProfileResponse>(
        Method.get,
        endPoint: Api.profileApiCall,
        options: Options(headers: header),
        onSuccess: (data)  {
          Log.d("${data.profileDataBean.name}");
          if (data != null) {
            view.provider.setData(data.profileDataBean);
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

  showProgress(){
    WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: 30.h,
        alignment: Alignment.center,
        child: Lottie.asset('assets/images/png/loading.json', width: 10.w),
      ),
    );
  }

}
