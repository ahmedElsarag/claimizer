import 'package:Cliamizer/network/models/LoginResponse.dart';
import 'package:Cliamizer/network/models/general_response.dart';

import 'models/NewLinkRequestResponse.dart';
import 'models/ProfileResponse.dart';
import 'models/StatisticsResponse.dart';
import 'models/UnitRequestResponse.dart';
import 'models/buildings_response.dart';
import 'models/categories_response.dart';
import 'models/claim_available_time_response.dart';
import 'models/claim_request_response.dart';
import 'models/claim_type_response.dart';
import 'models/claims_response.dart';
import 'models/units_response.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    switch (T.toString()) {
      case "GeneralResponse":
        return GeneralResponse.fromJson(json) as T;
        break;
      case "LoginResponse":
        return LoginResponse.fromJson(json) as T;
        break;
      case "StatisticsResponse":
        return StatisticsResponse.fromJson(json) as T;
        break;
      case "ClaimsResponse":
        return ClaimsResponse.fromJson(json) as T;
        break;
      case "ProfileResponse":
        return ProfileResponse.fromJson(json) as T;
        break;
      case "BuildingsResponse":
        return BuildingsResponse.fromJson(json) as T;
        break;
      case "UnitsResponse":
        return UnitsResponse.fromJson(json) as T;
        break;
      case "CategoriesResponse":
        return CategoriesResponse.fromJson(json) as T;
        break;
      case "ClaimTypeResponse":
        return ClaimTypeResponse.fromJson(json) as T;
        break;
      case "UnitRequestsResponse":
        return UnitRequestsResponse.fromJson(json) as T;
        break;
      case "NewLinkRequestResponse":
        return NewLinkRequestResponse.fromJson(json) as T;
        break;
      case "ClaimAvailableTimeResponse":
        return ClaimAvailableTimeResponse.fromJson(json) as T;
        break;
      case "ClaimsRequestResponse":
        return ClaimsRequestResponse.fromJson(json) as T;
        break;
      default:
        return null;
    }
  }
}
