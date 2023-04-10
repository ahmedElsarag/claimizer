import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/NewLinkRequestResponse.dart';
import 'package:Cliamizer/network/models/UnitRequestResponse.dart';
import 'package:Cliamizer/network/models/claims_response.dart';
import 'package:Cliamizer/network/models/units_response.dart';
import 'package:dio/dio.dart';

import '../../CommonUtils/preference/Prefs.dart';
import '../../generated/l10n.dart';
import '../../network/api/network_api.dart';
import '../../network/models/general_response.dart';
import '../../network/network_util.dart';
import 'units_screen.dart';

class UnitPresenter extends BasePresenter<UnitsScreenState> {
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
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@############ ${view.provider.unitsList[0].name}");
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@############ ${data.data[0].name}");
        print("@@@@@@@@@@@@@@@@@@@ : ${view.provider.unitsList.length}");
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
        view.provider.newLinkRequestDataBean = data.data;
        if (data.status == "success") {
          view.provider.isQrCodeValid = !view.provider.isQrCodeValid;
        } else if (data.status == "fail") {
          view.provider.isQrCodeValid = false;
          view.provider.message = data.message;
        }
      }
    }, onError: (code, msg) {
      view.closeProgress();
      if (code == 422) {
        view.showWarningToasts(
          S.current.anErrorOccurredTryAgainLater,
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
         view.showToasts(data.message);
        } else if (data.status == "fail") {
          view.showToasts(data.message);
        }
      }
    }, onError: (code, msg) {
      view.closeProgress();
      if (code == 422) {
        view.showWarningToasts(
          S.current.anErrorOccurredTryAgainLater,
        );
      }
    });
  }
}
