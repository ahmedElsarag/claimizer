import 'dart:io';

import 'package:Cliamizer/network/models/buildings_response.dart';
import 'package:Cliamizer/network/models/categories_response.dart';
import 'package:Cliamizer/network/models/claim_available_time_response.dart';
import 'package:Cliamizer/network/models/claim_type_response.dart';
import 'package:Cliamizer/network/models/units_response.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../network/models/claims_response.dart';

class ClaimsProvider extends ChangeNotifier {
  int _selectedIndex = 1;
  DateTime _selectedDate;

  TextEditingController _description = TextEditingController();

  int companyId;

  String _selectedTimeValue;

  // String _description;
  File _fileName;
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  DateTime get selectedDate {
    return _selectedDate ?? DateTime.now();
  }

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  set searchController(TextEditingController value) {
    _searchController = value;
    notifyListeners();
  }
  String _status;

  String get status => _status;

  set status(String value) {
    _status = value;
    notifyListeners();
  }

  String _searchValue = '';

  String get searchValue => _searchValue;

  set searchValue(String value) {
    _searchValue = value;
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

  List<BuildingsDataBean> _buildingsList = [];

  List<BuildingsDataBean> get buildingsList => _buildingsList;

  set buildingsList(List<BuildingsDataBean> value) {
    _buildingsList = value;
    notifyListeners();
  }

  List<UnitsDataBean> _unitsList = [];

  List<UnitsDataBean> get unitsList => _unitsList;

  set unitsList(List<UnitsDataBean> value) {
    _unitsList = value;
    notifyListeners();
  }

  void clearUnitsList() {
    _unitsList.clear();
    notifyListeners();
  }

  List<CategoryDataBean> _categoriesList = [];

  List<CategoryDataBean> get categoriesList => _categoriesList;

  set categoriesList(List<CategoryDataBean> value) {
    _categoriesList = value;
    notifyListeners();
  }

  void clearCategoryList() {
    _categoriesList.clear();
    notifyListeners();
  }

  List<SubCategoryDataBean> _subCategoryList = [];

  List<SubCategoryDataBean> get subCategoryList => _subCategoryList;

  set subCategoryList(List<SubCategoryDataBean> value) {
    _subCategoryList = value;
    notifyListeners();
  }

  void clearSubCategoryList() {
    _subCategoryList.clear();
    notifyListeners();
  }

  List<ClaimTypeDataBean> _claimTypeList = [];

  List<ClaimTypeDataBean> get claimTypeList => _claimTypeList;

  set claimTypeList(List<ClaimTypeDataBean> value) {
    _claimTypeList = value;
    notifyListeners();
  }

  void clearTypeList() {
    _claimTypeList.clear();
    notifyListeners();
  }

  List<ClaimAvailableTimeDataBean> _claimAvailableTimeList = [];

  List<ClaimAvailableTimeDataBean> get claimAvailableTimeList => _claimAvailableTimeList;

  set claimAvailableTimeList(List<ClaimAvailableTimeDataBean> value) {
    _claimAvailableTimeList = value;
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


  String get selectedTimeValue => _selectedTimeValue;

  set selectedTimeValue(String value) {
    _selectedTimeValue = value;
    notifyListeners();
  }

  TextEditingController get description => _description;

  set description(TextEditingController value) {
    _description = value;
    notifyListeners();
  } // String get description => _description;
  //
  // set description(String value) {
  //   _description = value;
  //   notifyListeners();
  // }

  File get fileName => _fileName;

  void updateFileName(File newFile) {
    _fileName = newFile;
    notifyListeners();
  }

  File _file;
  List<XFile> _imageFiles;


  File get file => _file;

  set file(File value) {
    _file = value;
    notifyListeners();
  }

  List<XFile> get imageFiles => _imageFiles;

  set imageFiles(List<XFile> value) {
    _imageFiles = value;
    notifyListeners();
  }

  bool _dataLoaded = false;

  bool get dataLoaded => _dataLoaded;

  set dataLoaded(bool value) {
    _dataLoaded = value;
    notifyListeners();
  }

  String selectedBuilding;
  String selectedUnit;
  String selectedCategory;
  String selectedSubCategory;
  String selectedType;
}
