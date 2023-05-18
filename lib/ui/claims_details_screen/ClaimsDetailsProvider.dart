import 'dart:io';

import 'package:Cliamizer/base/provider/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ClaimsDetailsProvider<T> extends BaseProvider<T> {
  bool _isDateLoaded = false;
  bool _internetStatus = true;


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
  File _file;
  List<XFile> _imageFiles;

  List<XFile> get imageFiles => _imageFiles;

  void  updateImageFiles(List<XFile> value) {
    _imageFiles = value;
    notifyListeners();
  }

  File get file => _file;

  void updateCommentFile(File newFile) {
    _file = newFile;
    notifyListeners();
  }

  TextEditingController get comment => _comment;

  set comment(TextEditingController value) {
    _comment = value;
    notifyListeners();
  }
}
