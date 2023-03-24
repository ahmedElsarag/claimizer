import 'package:Cliamizer/base/provider/base_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import '../../network/models/claims_response.dart';

class UnitProvider<T> extends BaseProvider<T> {
  TextEditingController _description = TextEditingController();
  TextEditingController _buildingName = TextEditingController();
  TextEditingController _qrCode = TextEditingController();
  bool _qrCodeValid;

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
  String _fileName = "";
  bool _isQrCodeValid = false;

  bool get isQrCodeValid => _isQrCodeValid;

  set isQrCodeValid(bool value) {
    _isQrCodeValid = value;
    notifyListeners();
  }

  List<ClaimsDataBean> _claimsList = [];

  List<ClaimsDataBean> get claimsList => _claimsList;

  set claimsList(List<ClaimsDataBean> value) {
    _claimsList = value;
    notifyListeners();
  }

  TextEditingController get description => _description;

  set description(TextEditingController value) {
    _description = value;
    notifyListeners();
  }

  String get fileName => _fileName;

  set fileName(String value) {
    _fileName = value;
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
}
