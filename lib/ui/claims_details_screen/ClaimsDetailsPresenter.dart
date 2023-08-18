import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/ClaimDetailsResponse.dart';
import 'package:Cliamizer/network/models/general_response.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/model_eventbus/EventBusUtils.dart';
import '../../CommonUtils/model_eventbus/ReloadClaimsEevet.dart';
import '../../CommonUtils/model_eventbus/ReloadHomeEevet.dart';
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
        onSuccess: (data) {
          view.closeProgress();
          Log.d("${data.data.id}");
          if (data != null) {
            view.provider.setData(data.data);
            view.provider.isDateLoaded = true;
          }
        },
        onError: (code, msg) {
          view.closeProgress();
          if (code == ErrorStatus.NOT_FOUND || code == ErrorStatus.PARSE_ERROR) {
            view.showToasts(S.of(view.context).noClaimFound, "error");
            Navigator.pop(view.context);
          }
          if (code == ErrorStatus.UNKNOWN_ERROR) view.provider.internetStatus = false;
          if (code == ErrorStatus.UNAUTHORIZED)
            showDialog(
                context: view.context,
                builder: (_) => LoginRequiredDialog(message: S.of(view.context).sessionTimeoutPleaseLogin),
                barrierDismissible: false);
          Log.d(msg);
        },
      );
    });
  }

  Future doPostCommentApiCall(dynamic bodyParams,String claimId) async {
    view.showProgress();

    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    await requestFutureData<GeneralResponse>(Method.post,
        endPoint: Api.doAddCommentToClaimApiCall, params: bodyParams, options: Options(headers: header), onSuccess: (data) {
          view.closeProgress();
          if (data != null) {
            Log.d("onSuccess " + data.toString());
            Navigator.pop(view.context);
            view.showToasts(S.of(view.context).commentAdded, 'success');
            getClaimDetailsDataApiCall(claimId);
            view.provider.imageFiles = null;
            view.provider.file = null;
            view.provider.comment.clear();
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


  closeClaimApiCall(String code) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token)  {
      view.showProgress(isDismiss: false);
      header['Authorization'] = "Bearer $token";
      requestFutureData<GeneralResponse>(
        Method.post,
        endPoint: Api.closeClaimDetailsApiCall(code),
        options: Options(headers: header),
        onSuccess: (data)  {
          if (data != null) {
            view.closeProgress();
            Navigator.pop(view.context);
            passReloadByEventPath();
            view.showToasts(S.of(view.context).claimClosed, "success");
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

  void passReloadByEventPath({bool isRefresh,}) {
    EventBus eventBus = EventBusUtils.getInstance();
    eventBus.fire(ReloadEvent(isRefresh: true));
    eventBus.fire(ReloadClaimsEvent(isRefresh:true));
  }
}
