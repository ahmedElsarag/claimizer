import 'package:flutter/material.dart';

import '../../network/models/claims_response.dart';

class ClaimsProvider extends ChangeNotifier {
  int _selectedIndex = 1;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  List<String> _times = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM'
  ];
  List<String> _unitItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6'
  ];

  List<String> get unitItems => _unitItems;

  set unitItems(List<String> value) {
    _unitItems = value;
    notifyListeners();
  }

  String _selectedTimeValue;
  String _description;
  String _fileName = "";
  int _currentStep = 0;
  bool _isStepsFinished = false;

  bool get isStepsFinished => _isStepsFinished;

  set isStepsFinished(bool value) {
    _isStepsFinished = value;
    notifyListeners();
  }

  int _selectedBuildingIndex;
  int _selectedUnitIndex;
  int _selectedClaimCategoryIndex;
  int _selectedClaimSubCategoryIndex;
  int _selectedClaimTypeIndex ;

  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0.0;

  double get scrollPosition => _scrollPosition;

  set scrollPosition(double value) {
    _scrollPosition = value;
    notifyListeners();
  }

  ScrollController get scrollController => _scrollController;

  set scrollController(ScrollController value) {
    _scrollController = value;
    notifyListeners();
  }

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  int get currentStep => _currentStep;

  set currentStep(int value) {
    _currentStep = value;
    notifyListeners();
  }

  int get selectedBuildingIndex => _selectedBuildingIndex;

  set selectedBuildingIndex(int value) {
    _selectedBuildingIndex = value;
    notifyListeners();
  }

  int get selectedUnitIndex => _selectedUnitIndex;

  set selectedUnitIndex(int value) {
    _selectedUnitIndex = value;
    notifyListeners();
  }

  List<ClaimsDataBean> _claimsList = [];

  List<ClaimsDataBean> get claimsList => _claimsList;

  set claimsList(List<ClaimsDataBean> value) {
    _claimsList = value;
    notifyListeners();
  }

  int get selectedClaimCategoryIndex => _selectedClaimCategoryIndex;

  set selectedClaimCategoryIndex(int value) {
    _selectedClaimCategoryIndex = value;
    notifyListeners();
  }

  int get selectedClaimTypeIndex => _selectedClaimTypeIndex;

  set selectedClaimTypeIndex(int value) {
    _selectedClaimTypeIndex = value;
    notifyListeners();
  }

  int get selectedClaimSubCategoryIndex => _selectedClaimSubCategoryIndex;

  set selectedClaimSubCategoryIndex(int value) {
    _selectedClaimSubCategoryIndex = value;
    notifyListeners();
  }

  TimeOfDay get selectedTime => _selectedTime;

  set selectedTime(TimeOfDay value) {
    _selectedTime = value;
    notifyListeners();
  }

  List<String> get times => _times;

  set times(List<String> value) {
    _times = value;
    notifyListeners();
  }

  String get selectedTimeValue => _selectedTimeValue;

  set selectedTimeValue(String value) {
    _selectedTimeValue = value;
    notifyListeners();
  }

  String get description => _description;

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  String get fileName => _fileName;

  set fileName(String value) {
    _fileName = value;
    notifyListeners();
  }
}
