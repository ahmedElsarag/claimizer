import 'package:flutter/cupertino.dart';

import '../../network/models/StatisticsResponse.dart';

class HomeProvider extends ChangeNotifier {
  List<String> _claimsStatistics = [];

  List<String> get claimsStatistics => _claimsStatistics;

  set claimsStatistics(List<String> value) {
    _claimsStatistics = value;
    notifyListeners();
  }

  List<AboutToExpireUnits> _rememberThatList = [];

  List<AboutToExpireUnits> get rememberThatList => _rememberThatList;

  set rememberThatList(List<AboutToExpireUnits> value) {
    _rememberThatList = value;
    notifyListeners();
  }


  String _name;

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String _avatar;

  String get avatar => _avatar;

  set avatar(String value) {
    _avatar = value;
    notifyListeners();
  }
}
