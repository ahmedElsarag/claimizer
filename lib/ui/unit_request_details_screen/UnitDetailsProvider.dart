import 'dart:io';

import 'package:Cliamizer/base/provider/base_provider.dart';
import 'package:Cliamizer/network/models/UnitRequestDetailsResponse.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UnitDetailsProvider<T> extends BaseProvider<UnitRequestDetailsDataBean> {
  bool _isDateLoaded = false;
  bool _internetStatus = true;
  TextEditingController _contractNo = TextEditingController();
  DateTime _endDate;

  File get contractImg => _contractImg;

  set contractImg(File value) {
    _contractImg = value;
    notifyListeners();
  }

  File _contractImg;
  File _identityImg;

  File _file;
  List<XFile> _imageFiles;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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


  TextEditingController get contractNo => _contractNo;

  set contractNo(TextEditingController value) {
    _contractNo = value;
    notifyListeners();
  }

  bool get internetStatus => _internetStatus;

  set internetStatus(bool value) {
    _internetStatus = value;
    notifyListeners();
  }

  bool get isDateLoaded => _isDateLoaded;

  set isDateLoaded(bool value) {
    _isDateLoaded = value;
    notifyListeners();
  }

  TextEditingController _comment = TextEditingController();
  TextEditingController _renewNotes = TextEditingController();

  TextEditingController get renewNotes => _renewNotes;

  set renewNotes(TextEditingController value) {
    _renewNotes = value;
    notifyListeners();
  }

  TextEditingController get comment => _comment;

  set comment(TextEditingController value) {
    _comment = value;
    notifyListeners();
  }

  DateTime get endDate => _endDate;

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  File get identityImg => _identityImg;

  set identityImg(File value) {
    _identityImg = value;
    notifyListeners();
  }
  DateTime _unlinkDate;
  String _unlinkStatus;
  TextEditingController _unlinkReason = TextEditingController();

  TextEditingController get unlinkReason => _unlinkReason;

  set unlinkReason(TextEditingController value) {
    _unlinkReason = value;
    notifyListeners();
  }

  DateTime get unlinkDate => _unlinkDate;

  set unlinkDate(DateTime value) {
    _unlinkDate = value;
    notifyListeners();
  }

  String get unlinkStatus => _unlinkStatus;

  set unlinkStatus(String value) {
    _unlinkStatus = value;
    notifyListeners();
  }
  GlobalKey<FormState> _formKeyRenew = GlobalKey<FormState>();

  GlobalKey<FormState> get formKeyRenew => _formKeyRenew;

  set formKeyRenew(GlobalKey<FormState> value) {
    _formKeyRenew = value;
    notifyListeners();
  }
}
