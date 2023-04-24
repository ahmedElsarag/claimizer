import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/buildings_response.dart';
import 'package:Cliamizer/network/models/categories_response.dart';
import 'package:Cliamizer/network/models/claim_available_time_response.dart';
import 'package:Cliamizer/network/models/claim_request_response.dart';
import 'package:Cliamizer/network/models/claims_response.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/success_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../CommonUtils/preference/Prefs.dart';
import '../../network/api/network_api.dart';
import '../../network/models/claim_type_response.dart';
import '../../network/models/units_response.dart';
import '../../network/network_util.dart';
import 'claims_screen.dart';

class ClaimsPresenter extends BasePresenter<ClaimsScreenState> {
  Future getAllClaimsApiCall() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimsResponse>(Method.get, options: Options(headers: header), endPoint: Api.claimsApiCall,
        onSuccess: (data) {
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
    await requestFutureData<BuildingsResponse>(Method.get,
        options: Options(headers: header), endPoint: Api.buildingsApiCall, onSuccess: (data) {
      view.provider.dataLoaded = true;
      if (data != null) {
        view.provider.buildingsList = data.data;
      }
    }, onError: (code, msg) {
          view.provider.dataLoaded = true;
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
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  Future postClaimRequestApiCall() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    print("!@!#!#!@#@#!@# ${view.provider.description}");
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimsRequestResponse>(Method.post,
        params: {
          "unit_id": view.selectedUnitId,
          "category_id": view.selectedCategoryId,
          "sub_category_id": view.selectedSubCategoryId,
          "claim_type_id": view.selectedTypeId,
          "description": view.provider.description,
          "available_date": DateFormat('yyyy-MM-dd', 'en').format(view.provider.selectedDate),
          "available_time": view.provider.selectedTimeValue
        },
        options: Options(headers: header),
        endPoint: Api.claimsApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        showDialog(
          context: view.context,
          builder: (context) => ClaimCreatedDialog(),
        );
      }
    }, onError: (code, msg) {
      view.closeProgress();
      view.showToasts(msg, "error");
    });
  }
}
