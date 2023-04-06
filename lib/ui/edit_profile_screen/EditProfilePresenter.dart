import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/general_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../app_widgets/LoginRequiredDialog.dart';
import '../../generated/l10n.dart';
import '../../network/api/network_api.dart';
import '../../network/exception/error_status.dart';
import '../../network/models/ProfileResponse.dart';
import '../../network/network_util.dart';
import 'EditProfileScreen.dart';

class EditProfilePresenter extends BasePresenter<EditProfileScreenState> {
  getProfileData() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      print('@@@@@@@@@@@@@@@@@@@@@$token');
      header['Authorization'] = "Bearer $token";
    });
    requestFutureData<ProfileResponse>(
      Method.get,
      endPoint: Api.profileApiCall,
      options: Options(headers: header),
      onSuccess: (data) {
        Log.d("${data.profileDataBean.name}");
        if (data != null) {
          view.provider.setData(data.profileDataBean);
          view.provider.isDateLoaded = true;
          view.closeProgress();
        } else {
          view.closeProgress();
        }
      },
      onError: (code, msg) {
        Log.d(msg);
        if (code == ErrorStatus.UNKNOWN_ERROR) view.provider.internetStatus = false;
        view.closeProgress();
        if (code == ErrorStatus.UNAUTHORIZED)
          showDialog(
              context: view.context,
              builder: (_) => LoginRequiredDialog(message: S.of(view.context).sessionTimeoutPleaseLogin),
              barrierDismissible: false);
      },
    );
  }

  Future doEditPassword(Map<String, dynamic> bodyParams) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      print('@@@@@@@@@@@@@@@@@@@@@$token');
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<GeneralResponse>(Method.post,
        endPoint: Api.editPasswordApiCall, params: bodyParams, options: Options(headers: header), onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        Navigator.pop(view.context);
        view.showToasts(S.current.passwordChangedSuccessfully);
      }
    }, onError: (code, msg) {
      view.closeProgress();
      if(code == 422){
        view.showWarningToasts(S.current.anErrorOccurredTryAgainLater,);
      }
    });
  }

  Future doEditBasicInfoApiCall(FormData formData) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      print('@@@@@@@@@@@@@@@@@@@@@$token');
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<ProfileResponse>(Method.post,
        endPoint: Api.editBasicInfo, params: formData, options: Options(headers: header), onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        Navigator.pop(view.context);
        view.showToasts(S.current.passwordChangedSuccessfully);
      }
    }, onError: (code, msg) {
      view.closeProgress();
      if(code == 422){
        view.showWarningToasts(S.current.anErrorOccurredTryAgainLater,);
      }
    });
  }

  showProgress() {
    WillPopScope(
      onWillPop: () async => false,
      child: SpinKitPulse(
        size: 50.sp,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
                /*shape: BoxShape.rectangle,*/
                borderRadius: BorderRadius.circular(12),
                color:
                    /* index.isEven ? */
                    Theme.of(context).primaryColor
                /*     : MColors.gray_99,*/
                ),
          );
        },
      ),
    );
  }
}
