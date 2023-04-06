import 'package:Cliamizer/network/models/LoginResponse.dart';
import 'package:Cliamizer/network/models/general_response.dart';

import 'models/ProfileResponse.dart';
import 'models/StatisticsResponse.dart';
import 'models/claims_response.dart';

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
      default:
        return null;
    }
  }
}
