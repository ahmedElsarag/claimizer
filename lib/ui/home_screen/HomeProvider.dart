import 'package:flutter/cupertino.dart';

import '../../generated/l10n.dart';
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

  ClaimColor _claimStatusColors;

  ClaimColor get claimStatusColors => _claimStatusColors;

  set claimStatusColors(ClaimColor value) {
    _claimStatusColors = value;
    notifyListeners();
  }

  // List<String> _cardTitles = [
  //   S.current.allClaims,
  //   S.current.newClaims,
  //   S.current.assignedClaims,
  //   S.current.startedClaims,
  //   S.current.completedClaims,
  //   S.current.cancelledClaims,
  //   S.current.closedClaims
  // ];

  // List<String> get cardTitles => _cardTitles;
  //
  // set cardTitles(List<String> value) {
  //   _cardTitles = value;
  //   notifyListeners();
  // }
}
