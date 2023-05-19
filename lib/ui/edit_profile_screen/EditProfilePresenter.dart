import 'dart:convert';

import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/general_response.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/model_eventbus/EventBusUtils.dart';
import '../../CommonUtils/model_eventbus/ProfileEvent.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../app_widgets/LoginRequiredDialog.dart';
import '../../app_widgets/NoInternetConnection.dart';
import '../../generated/l10n.dart';
import '../../network/api/network_api.dart';
import '../../network/exception/error_status.dart';
import '../../network/models/ProfileResponse.dart';
import '../../network/network_util.dart';
import 'EditProfileScreen.dart';

class EditProfilePresenter extends BasePresenter<EditProfileScreenState> {

  getProfileData() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token)  {
      view.showProgress();
      header['Authorization'] = "Bearer $token";
      requestFutureData<ProfileResponse>(
        Method.get,
        endPoint: Api.profileApiCall,
        options: Options(headers: header),
        onSuccess: (data)  {
          Log.d("${data.profileDataBean.name}");
          if (data != null) {
            view.provider.setData(data.profileDataBean);
            view.provider.nameController?.text = data.profileDataBean.name;
            view.provider.emailController?.text = data.profileDataBean.email;
            view.provider.mobileController?.text = data.profileDataBean.profile.mobile;
            view.provider.isNotificationEnabled = data.profileDataBean.profile.emailNotifications;
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

  Future doEditPassword(Map<String, dynamic> bodyParams) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<GeneralResponse>(Method.post,
        endPoint: Api.editPasswordApiCall, params: bodyParams, options: Options(headers: header), onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        Navigator.pop(view.context);
        view.showToasts(S.current.passwordChangedSuccessfully, 'success');
      }
    }, onError: (code, msg) {
      view.closeProgress();
      if (code == 422) {
        view.showToasts(S.current.anErrorOccurredTryAgainLater, 'warning');
      }
    });
  }

  Future editProfileApiCall(dynamic bodyParams) async {
    view.showProgress();

    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    await requestFutureData<ProfileResponse>(Method.post,
        endPoint: Api.editBasicInfo, params: bodyParams, options: Options(headers: header), onSuccess: (data) {
      view.closeProgress();
      if (data.profileDataBean != null) {
        Log.d("onSuccess " + data.toString());
        saveUser(data);
        passUserByEventPath(
            username: data.profileDataBean.name,
            imageUrl: data.profileDataBean.avatar,
            email: data.profileDataBean.email);
        Navigator.pop(view.context);
        view.showToasts(S.of(view.context).profileUpdatedSuccessfully, 'success');
      } else {
        view.showToasts("Error", 'error');
      }
    }, onError: (code, msg) {
      Log.d(msg);
      view.closeProgress();
      if (code == ErrorStatus.UNAUTHORIZED) {
        showDialog(
            context: view.context,
            builder: (_) => LoginRequiredDialog(message: S.of(view.context).sessionTimeoutPleaseLogin),
            barrierDismissible: false);
      } else {
        view.showToasts("Error", 'error');
      }
    });
  }

  void saveUser(ProfileResponse response) {
    Prefs.setUserName(response.profileDataBean.name);
    Prefs.setCurrentUser(jsonEncode(response.toJson()));
    Prefs.setUserImage(response.profileDataBean.avatar);
  }

  void saveUserImage(String image) {
    Prefs.setUserImage(image);
  }

  void passUserByEventPath({String username, String email, String imageUrl}) {
    EventBus eventBus = EventBusUtils.getInstance();
    eventBus.fire(ProfileEvent(username: username, userEmail: email, userImage: imageUrl));
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

  Widget showMessage(){
    if(view.provider.internetStatus){
      return Center();
    }else{
      return NoInternetConnection(onTap: (){
        getProfileData();
        view.showProgress();
      }
      );
    }
  }
}
