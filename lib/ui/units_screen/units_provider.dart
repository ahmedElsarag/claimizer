import 'dart:io';

import 'package:Cliamizer/base/provider/base_provider.dart';
import 'package:Cliamizer/network/models/units_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../network/models/NewLinkListRequestResponse.dart';
import '../../network/models/NewLinkRequestResponse.dart';
import '../../network/models/UnitRequestResponse.dart';
import '../../network/models/claims_response.dart';

class UnitProvider<T> extends BaseProvider<T> {
  TextEditingController _description = TextEditingController();
  TextEditingController _buildingName = TextEditingController();
  TextEditingController _qrCode = TextEditingController();
  bool _qrCodeValid;
  String _message;

  String get message => _message;

  set message(String value) {
    _message = value;
    notifyListeners();
  }

  bool get qrCodeValid => _qrCodeValid;

  set qrCodeValid(bool value) {
    _qrCodeValid = value;
    notifyListeners();
  }

  TextEditingController get qrCode => _qrCode;

  set qrCode(TextEditingController value) {
    _qrCode = value;
    notifyListeners();
  }

  TextEditingController get buildingName => _buildingName;

  set buildingName(TextEditingController value) {
    _buildingName = value;
    notifyListeners();
  }

  bool _isBuilding = false;

  bool get isBuilding => _isBuilding;

  set isBuilding(bool value) {
    _isBuilding = value;
    notifyListeners();
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  TextEditingController _companyName = TextEditingController();
  TextEditingController _contractNo = TextEditingController();
  DateTime _startDate;
  DateTime _endDate;
  File _contractImg;
  File _identityImg;

  File get identityImg => _identityImg;

  set identityImg(File value) {
    _identityImg = value;
    notifyListeners();
  }



  List<XFile> _contractFiles;
  List<XFile> _identityFiles;

  set contractImg(File value) {
    _contractImg = value;
    notifyListeners();
  }

  List<XFile> get contractFiles => _contractFiles;

  set contractFiles(List<XFile> value) {
    _contractFiles = value;
    notifyListeners();
  }

  List<XFile> get identityFiles => _identityFiles;

  set identityFiles(List<XFile> value) {
    _identityFiles = value;
    notifyListeners();
  }

  File get contractImg => _contractImg;

  void updateContractImg(File newFile) {
    _contractImg = newFile;
    notifyListeners();
  }

  bool _isQrCodeValid = false;

  bool get isQrCodeValid => _isQrCodeValid;

  set isQrCodeValid(bool value) {
    _isQrCodeValid = value;
    notifyListeners();
  }

  NewLinkRequestDataBean _newLinkRequestDataBean;

  NewLinkRequestDataBean get newLinkRequestDataBean => _newLinkRequestDataBean;

  set newLinkRequestDataBean(NewLinkRequestDataBean value) {
    _newLinkRequestDataBean = value;
    notifyListeners();
  }

  String _buildingUnitCode;

  String get buildingUnitCode => _buildingUnitCode;

  set buildingUnitCode(String value) {
    _buildingUnitCode = value;
    notifyListeners();
  }

  NewLinkListRequestDataBean _linkListRequestDataBean;

  NewLinkListRequestDataBean get linkListRequestDataBean => _linkListRequestDataBean;

  set linkListRequestDataBean(NewLinkListRequestDataBean value) {
    _linkListRequestDataBean = value;
    notifyListeners();
  }

  List<UnitsList> _buildingUnitsList = [];

  List<UnitsList> get buildingUnitsList => _buildingUnitsList;

  set buildingUnitsList(List<UnitsList> value) {
    _buildingUnitsList = value;
    notifyListeners();
  }

  String _searchValue = '';

  String get searchValue => _searchValue;

  set searchValue(String value) {
    _searchValue = value;
    notifyListeners();
  }

  TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  set searchController(TextEditingController value) {
    _searchController = value;
    notifyListeners();
  }

  TextEditingController _unitLinkSearchController = TextEditingController();

  TextEditingController get unitLinkSearchController => _unitLinkSearchController;

  set unitLinkSearchController(TextEditingController value) {
    _unitLinkSearchController = value;
    notifyListeners();
  }

  String _selectedUnit;

  String get selectedUnit => _selectedUnit;

  set selectedUnit(String value) {
    _selectedUnit = value;
    notifyListeners();
  }

  List<UnitsDataBean> _unitsList = [];

  List<UnitsDataBean> get unitsList => _unitsList;

  set unitsList(List<UnitsDataBean> value) {
    _unitsList = value;
    notifyListeners();
  }

  List<UnitRequestDataBean> _unitsRequestList = [];

  List<UnitRequestDataBean> get unitsRequestList => _unitsRequestList;

  set unitsRequestList(List<UnitRequestDataBean> value) {
    _unitsRequestList = value;
    notifyListeners();
  }

  TextEditingController get description => _description;

  set description(TextEditingController value) {
    _description = value;
    notifyListeners();
  }

  TextEditingController get companyName => _companyName;

  set companyName(TextEditingController value) {
    _companyName = value;
    notifyListeners();
  }

  TextEditingController get contractNo => _contractNo;

  set contractNo(TextEditingController value) {
    _contractNo = value;
    notifyListeners();
  }

  DateTime get startDate => _startDate;

  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  DateTime get endDate => _endDate;

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  bool _validated = false;

  bool get validated => _validated;

  set validated(bool value) {
    _validated = value;
    notifyListeners();
  }
}
