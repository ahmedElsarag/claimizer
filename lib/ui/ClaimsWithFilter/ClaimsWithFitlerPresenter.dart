import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/buildings_response.dart';
import 'package:Cliamizer/network/models/categories_response.dart';
import 'package:Cliamizer/network/models/claim_available_time_response.dart';
import 'package:Cliamizer/network/models/claim_request_response.dart';
import 'package:Cliamizer/network/models/claims_response.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/success_dialog.dart';
import 'package:Cliamizer/ui/home_screen/HomeProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/preference/Prefs.dart';
import '../../network/api/network_api.dart';
import '../../network/models/claim_type_response.dart';
import '../../network/models/units_response.dart';
import '../../network/network_util.dart';
import 'ClaimsWithFilterScreen.dart';

class ClaimsWithFilterPresenter extends BasePresenter<ClaimsWithFilterScreenState> {

  Future getFilteredClaimsWithStatusApiCall(String status) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimsResponse>(Method.get,
        options: Options(headers: header),
        queryParams: {"status": status},
        endPoint: Api.claimsApiCall, onSuccess: (data) {
      if (data != null) {
        view.provider.claimsList = data.data;
      }
      view.closeProgress();
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  Future getFilteredClaimsApiCall(Map<String, dynamic> params) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimsResponse>(Method.get,
        options: Options(headers: header), queryParams: params, endPoint: Api.claimsApiCall, onSuccess: (data) {
          if (data != null) {
            view.provider.claimsList = data.data;
          }
          view.closeProgress();
        }, onError: (code, msg) {
          view.closeProgress();
        });
  }

  formatDate(String date) {
    if (date != null || date.isNotEmpty) return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    return null;
  }

  showProgress() {
    WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: 30.h,
        alignment: Alignment.center,
        child: Lottie.asset('assets/images/png/loading.json', width: 10.w),
      ),
    );
  }

  Color getClaimStatusColorFromString(String status) {
    HomeProvider homeProvider = view.context.read<HomeProvider>();
    switch (status) {
      case 'new':
      case 'جديد':
        return HexColor(homeProvider.claimStatusColors.newClaims ?? '#ff9500');
      case 'assigned':
      case 'تم اختيار فني':
      case 'renewing':
      case 'active':
        return HexColor(homeProvider.claimStatusColors.assigned ?? '#ff9500');
      case 'started':
      case 'بدأت':
        return HexColor(homeProvider.claimStatusColors.started ?? '#ff9500');
      case 'completed':
      case 'مكتمل':
        return HexColor(homeProvider.claimStatusColors.completed ?? '#ff9500');
      case 'closed':
      case 'مغلق':
        return HexColor(homeProvider.claimStatusColors.closed ?? '#ff9500');
      case 'cancelled':
      case 'ملغي':
        return HexColor(homeProvider.claimStatusColors.cancelled ?? '#ff9500');
      default:
        return Color(0xff44A4F2).withOpacity(0.08);
    }
  }
}
