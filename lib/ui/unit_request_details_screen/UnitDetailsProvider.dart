import 'dart:io';

import 'package:Cliamizer/base/provider/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UnitDetailsProvider<T> extends BaseProvider<T> {
  bool _isDateLoaded = false;
  bool _internetStatus = true;
  TextEditingController _contractNo = TextEditingController();
  DateTime _endDate;
  File _contractImg;
  File _identityImg;

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

  File get contractImg => _contractImg;

  void updateContractImg(File newFile) {
    _contractImg = newFile;
    notifyListeners();
  }

  File get identityImg => _identityImg;

  void updateIdentityImg(File value) {
    _identityImg = value;
    notifyListeners();
  }
}
