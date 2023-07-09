import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/ClaimDetailsResponse.dart';
import 'package:Cliamizer/network/models/UnitRequestDetailsResponse.dart';
import 'package:Cliamizer/network/models/general_response.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../CommonUtils/image_utils.dart';
import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/model_eventbus/EventBusUtils.dart';
import '../../CommonUtils/model_eventbus/ReloadHomeEevet.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../app_widgets/LoginRequiredDialog.dart';
import '../../generated/l10n.dart';
import '../../network/api/network_api.dart';
import '../../network/exception/error_status.dart';
import '../../network/network_util.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import 'UnitDetailsScreen.dart';


class UnitDetailsPresenter extends BasePresenter<UnitRequestDetailsScreenState> {
  getUnitRequestDetailsDataApiCall(int id) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token)  {
      view.showProgress(isDismiss: false);
      header['Authorization'] = "Bearer $token";
      requestFutureData<UnitRequestDetailsResponse>(
        Method.get,
        endPoint: Api.getUnitRequestDetailsApiCall(id),
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

  Future doPostCommentApiCall(dynamic bodyParams,int unitID) async {
    view.showProgress();

    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    await requestFutureData<GeneralResponse>(Method.post,
        endPoint: Api.doAddCommentToUnitRequestApiCall, params: bodyParams, options: Options(headers: header), onSuccess: (data) {
          view.closeProgress();
          if (data != null) {
            Log.d("onSuccess " + data.toString());
            Navigator.pop(view.context);
            view.showToasts(S.of(view.context).commentAdded, 'success');
            view.provider.comment.clear();
            getUnitRequestDetailsDataApiCall(unitID);
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
  
  unlinkUnitRequestApiCall(Map<String,dynamic> params) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token)  {
      view.showProgress(isDismiss: false);
      header['Authorization'] = "Bearer $token";
      requestFutureData<GeneralResponse>(
        Method.post,
        endPoint: Api.unlinkUnitRequestDetailsApiCall,
        options: Options(headers: header),
        params: params,
        onSuccess: (data)  {
          if (data != null) {
            Navigator.pop(view.context);
            view.showToasts(S.of(view.context).unitRequestUnlinked, "success");
            getUnitRequestDetailsDataApiCall(view.widget.unitRequestDataBean.id);
            Navigator.pop(view.context);
            passReloadByEventPath(isRefresh: true);
            view.provider.unlinkDate = null;
            view.provider.unlinkReason.clear();
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

  Future renewUnitLinkRequestApiCall(FormData bodyParams,int unitID) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<GeneralResponse>(Method.post,
        endPoint: Api.renewUnitLinkRequestApiCall,
        params: bodyParams,
        options: Options(headers: header), onSuccess: (data) {
          view.closeProgress();
          if (data != null) {
            if (data.status == "success") {
              showDialog(
                context: view.context,
                builder: (context) => AlertDialog(
                  backgroundColor: MColors.whiteE,
                  elevation: 0,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(ImageUtils.getSVGPath("done")),
                      Gaps.vGap16,
                      Text(S.current.confirmation,
                          style: MTextStyles.textMain16.copyWith(
                            color: MColors.black,
                          )),
                      Gaps.vGap8,
                      Text(
                        S.current.thankYouForSubmittingYourRequestOneOfOurCustomerservices,
                        style: MTextStyles.textSubtitle,
                        textAlign: TextAlign.center,
                      ),
                      Gaps.vGap30,
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          view.provider.contractNo.clear();
                          view.provider.endDate = null;
                          view.provider.contractImg = null;
                          view.provider.identityImg = null;
                          getUnitRequestDetailsDataApiCall(unitID);
                          Navigator.pop(context);
                          passReloadByEventPath(isRefresh: true);
                        },
                        child: Text(
                          S.current.backToHome,
                          style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
                            elevation: MaterialStatePropertyAll(0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                      )
                    ],
                  ),
                ),
              );
            } else if (data.status == "fail") {
              view.showToasts(data.message, 'error');
            }
          }
        }, onError: (code, msg) {
          view.closeProgress();
          if (code == 422) {
            view.showToasts(S.current.anErrorOccurredTryAgainLater, 'warning');
          } else {
            view.showToasts(S.current.anErrorOccurredTryAgainLater, 'error');
          }
        });
  }


  void passReloadByEventPath({bool isRefresh,}) {
    EventBus eventBus = EventBusUtils.getInstance();
    eventBus.fire(ReloadEvent(isRefresh: true));
    print("IS REFRESHHHHHHHHHHHHHHH $isRefresh");
  }
}
