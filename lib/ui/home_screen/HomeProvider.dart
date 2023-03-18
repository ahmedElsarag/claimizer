import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  List<String> _claimsStatistics = [];

  List<String> get claimsStatistics => _claimsStatistics;

  set claimsStatistics(List<String> value) {
    _claimsStatistics = value;
    notifyListeners();
  }
}
