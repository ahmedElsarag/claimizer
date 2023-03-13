import 'package:Cliamizer/network/models/general_response.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    switch (T.toString()) {
      case "GeneralResponse":
        return GeneralResponse.fromJson(json) as T;
        break;
      default:
        return null;
    }
  }
}
