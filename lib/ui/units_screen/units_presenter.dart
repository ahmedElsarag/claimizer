import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/NewLinkRequestResponse.dart';
import 'package:Cliamizer/network/models/UnitRequestResponse.dart';
import 'package:Cliamizer/network/models/claims_response.dart';
import 'package:Cliamizer/network/models/units_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/image_utils.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../generated/l10n.dart';
import '../../network/api/network_api.dart';
import '../../network/models/general_response.dart';
import '../../network/network_util.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import 'units_screen.dart';

class UnitPresenter extends BasePresenter<UnitsScreenState> {
  // calculate to verify unit validated or not
  //   // https://beta.claimizer.com/client/properties?qr_code=U22-98940-10&contract_number=1&
  //   start_date=01-01-2022&end_date=01-01-2023&m=02024045
  //   /*
  //     m = (start date + end date) * contract number
  //     m = (01012022+ 01012023) * 1 = 02024045
  //     validated = true
  //   */

  Future getExistingUnitsApiCall() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<UnitsResponse>(Method.get, options: Options(headers: header), endPoint: Api.unitsApiCall,
        onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.provider.unitsList = data.data;
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  Future getUnitRequestsApiCall() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<UnitRequestsResponse>(Method.get,
        options: Options(headers: header), endPoint: Api.unitRequestApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.provider.unitsRequestList = data.data;
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  Future doCheckUnitQrCodeApiCall(Map<String, dynamic> bodyParams) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      print('@@@@@@@@@@@@@@@@@@@@@$token');
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<NewLinkRequestResponse>(Method.post,
        endPoint: Api.newLinkRequestApiCall, params: bodyParams, options: Options(headers: header), onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        if (data.status == "success") {
          view.provider.newLinkRequestDataBean = data.data;
          view.provider.isQrCodeValid = !view.provider.isQrCodeValid;
          } else if (data.status == "fail") {
          view.provider.message = data.data.message;
        print("@@@@@@@@@@@@@@@@@################## ${view.provider.message}");
        }
      }
    }, onError: (code, msg) {
      view.closeProgress();
      if(code == 404){
        view.provider.message = S.current.theQrCodeIsIncorrect;
      }

      if (code == 422) {
        view.showToasts(
          S.current.anErrorOccurredTryAgainLater,'error'
        );
      }
    });
  }

  Future completeLinkRequestApiCall(Map<String, dynamic> bodyParams) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      print('@@@@@@@@@@@@@@@@@@@@@$token');
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<GeneralResponse>(Method.post,
        endPoint: Api.completeLinkRequestApiCall, params: bodyParams, options: Options(headers: header), onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        if (data.status == "success") {
          showDialog(
            context: view.context,
            builder: (context) => AlertDialog(
              backgroundColor: MColors.whiteE,
              elevation: 0,
              contentPadding:
              EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
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
                      // view.provider.isQrCodeValid = !view.provider.isQrCodeValid;
                      view.provider.qrCode.clear();
                      view.provider.contractNo.clear();
                      view.provider.companyName.clear();
                      view.provider.buildingName.clear();
                      view.provider.description.clear();
                      view.provider.startDate=null;
                      view.provider.endDate = null;
                      view.provider.fileName = "";
                      view.provider.qrCodeValid = false;
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.current.backToHome,
                      style: MTextStyles.textWhite14
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            MColors.primary_color),
                        elevation: MaterialStatePropertyAll(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 3.w))),
                  )
                ],
              ),
            ),
          );
        } else if (data.status == "fail") {
          view.showToasts(data.message,'error');
        }
      }
    }, onError: (code, msg) {
      view.closeProgress();
      if (code == 422) {
        view.showToasts(
          S.current.anErrorOccurredTryAgainLater,'warning'
        );
      }else{
        view.showToasts(
          S.current.anErrorOccurredTryAgainLater,'warning'
        );
      }
    });
  }
}
