import 'package:Cliamizer/base/presenter/base_presenter.dart';
import 'package:Cliamizer/network/models/buildings_response.dart';
import 'package:Cliamizer/network/models/categories_response.dart';
import 'package:Cliamizer/network/models/claim_available_time_response.dart';
import 'package:Cliamizer/network/models/claim_request_response.dart';
import 'package:Cliamizer/network/models/claims_response.dart';
import 'package:dio/dio.dart';
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
      view.closeProgress();
      if (data != null) {
        print('########${data.data.length}');
        view.provider.claimsList = data.data;
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  formatDate(String date) {
    if (date != null || date.isNotEmpty) return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    return null;
  }

  Future getBuildingsApiCall() async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<BuildingsResponse>(Method.get,
        options: Options(headers: header), endPoint: Api.buildingsApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.provider.buildingsList = data.data;
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  Future getUnitsApiCall(int buildingId) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<UnitsResponse>(Method.get,
        queryParams: {'building': buildingId},
        options: Options(headers: header),
        endPoint: Api.unitsApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.provider.unitsList = data.data;
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  Future getCategoryApiCall(int unitId) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<CategoriesResponse>(Method.get,
        queryParams: {'property_unit_id': unitId, 'per_page': 1000},
        options: Options(headers: header),
        endPoint: Api.categoriesApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.provider.categoriesList = data.data;
      }
    }, onError: (code, msg) {
      view.closeProgress();
    });
  }

  Future getClaimTypeApiCall(int subCategoryId) async {
    Map<String, dynamic> header = Map();
    await Prefs.getUserToken.then((token) {
      header['Authorization'] = "Bearer $token";
    });
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimTypeResponse>(Method.get,
        queryParams: {'subcategory_id': subCategoryId, 'per_page': 1000},
        options: Options(headers: header),
        endPoint: Api.claimTypeApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        view.provider.claimTypeList = data.data;
      }
    }, onError: (code, msg) {
      view.closeProgress();
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
      print('@!@!@!@!@!${data}');
      if (data != null) {
        view.provider.claimAvailableTimeList = data.data;
        print('@!@!@!@!@!${view.provider.claimAvailableTimeList.length}');
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
    view.showProgress(isDismiss: false);
    await requestFutureData<ClaimsRequestResponse>(Method.post,
        params: {
          "unit_id": view.selectedUnit,
          "category_id": view.selectedCategory,
          "sub_category_id": view.selectedSubCategory,
          "claim_type_id": view.selectedType,
          "description": view.provider.description,
          "available_date": DateFormat('MM/dd/yyyy').format(view.provider.selectedDate),
          "available_time": view.provider.selectedTimeValue
        },
        options: Options(headers: header),
        endPoint: Api.claimsApiCall, onSuccess: (data) {
      view.closeProgress();
      if (data != null) {
        print('@!@!@!@!@!${data}');
      }
    }, onError: (code, msg) {
      view.closeProgress();
      view.showToasts(msg, "error");
    });
  }
}
