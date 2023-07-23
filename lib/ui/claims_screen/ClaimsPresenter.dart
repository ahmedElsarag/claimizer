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
import '../../app_widgets/NoDataFound.dart';
import '../../network/api/network_api.dart';
import '../../network/models/claim_type_response.dart';
import '../../network/models/units_response.dart';
import '../../network/network_util.dart';
import 'claims_screen.dart';

class ClaimsPresenter extends BasePresenter<ClaimsScreenState> {
  Future getAllClaimsApiCall(Map<String, dynamic> params/*int pageKey*/) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    // Map<String, dynamic> params = Map();
    // params['per_page'] = 20;
    // params['page'] = pageKey;
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimsResponse>(Method.get,
        queryParams: params, options: Options(headers: header), endPoint: Api.claimsApiCall, onSuccess: (data) {
      if (data != null) {
        view.closeProgress();
        view.provider.claimsList = data.data;
        view.provider.isLoading = false;
        print("LENGTH : ${view.provider.claimsList.length}");
        view.provider.lastPage = data.meta.pagination.totalPages;
      }
     getBuildingsApiCall();

    }, onError: (code, msg) {
      view.closeProgress();
     getBuildingsApiCall();
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

  Future getBuildingsApiCall() async {
    view.provider.dataLoaded = false;
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress();
    await requestFutureData<BuildingsResponse>(Method.get,
        options: Options(headers: header), endPoint: Api.buildingsApiCall, onSuccess: (data) {
      view.closeProgress();
      view.provider.dataLoaded = true;
      if (data != null) {
        view.provider.buildingsList = data.data;
      }
    }, onError: (code, msg) {
      view.provider.dataLoaded = true;
      view.closeProgress();
    });
  }

  Future getUnitsApiCall(int buildingId) async {
    view.provider.dataLoaded = false;
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.provider.clearUnitsList();
    await requestFutureData<UnitsResponse>(Method.get,
        queryParams: {'building': buildingId},
        options: Options(headers: header),
        endPoint: Api.unitsApiCall, onSuccess: (data) {
      view.provider.dataLoaded = true;
      if (data != null) {
        view.provider.unitsList = data.data;
      }
    }, onError: (code, msg) {
      view.provider.dataLoaded = true;
    });
  }

  Future getCategoryApiCall(int unitId) async {
    view.provider.dataLoaded = false;
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.provider.clearCategoryList();
    await requestFutureData<CategoriesResponse>(Method.get,
        queryParams: {'property_unit_id': unitId, 'per_page': 1000},
        options: Options(headers: header),
        endPoint: Api.categoriesApiCall, onSuccess: (data) {
      view.provider.dataLoaded = true;
      if (data != null) {
        view.provider.categoriesList = data.data;
      }
    }, onError: (code, msg) {
      view.provider.dataLoaded = true;
    });
  }

  Future getClaimTypeApiCall(int subCategoryId) async {
    view.provider.dataLoaded = false;
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.provider.clearTypeList();
    await requestFutureData<ClaimTypeResponse>(Method.get,
        queryParams: {'subcategory_id': subCategoryId, 'per_page': 1000},
        options: Options(headers: header),
        endPoint: Api.claimTypeApiCall, onSuccess: (data) {
      view.provider.dataLoaded = true;

      if (data != null) {
        view.provider.claimTypeList = data.data;
      }
    }, onError: (code, msg) {
      view.provider.dataLoaded = true;
    });
  }

  Future getClaimAvailableTimeApiCall() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimAvailableTimeResponse>(Method.get,
        queryParams: {'company_id': view.provider.companyId},
        options: Options(headers: header),
        endPoint: Api.claimAvailableTimeApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.provider.claimAvailableTimeList = data.data;
        view.provider.selectedTimeValue = data.data.isNotEmpty ? data.data[0].name : null;
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  Future postClaimRequestApiCall(dynamic formData) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimsRequestResponse>(Method.post,
        params: formData, options: Options(headers: header), endPoint: Api.claimsApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        showDialog(
          context: view.context,
          builder: (context) => ClaimCreatedDialog(
            presenter: view.mPresenter,
            claimsRequestResponse: data,
          ),
        );
        view.provider.file = null;
        view.provider.imageFiles = null;
        view.provider.description.clear();
      }
    }, onError: (code, msg) {
      view.closeProgress();
      view.showToasts(msg, "error");
    });
  }

  showProgress() {
    showDialog(
      context: view.context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            height: 30.h,
            alignment: Alignment.center,
            child: Lottie.asset('assets/images/png/loading.json', width: 10.w),
          ),
        );
      },
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

  Widget showMessage(){
    if(view.provider.claimsList.isEmpty)
      return Center(child: NoDataWidget(),);
    return showProgress();
  }
}
