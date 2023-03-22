import 'dart:io';

import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../../../res/colors.dart';

class BuildFilePicker extends StatelessWidget {
  const BuildFilePicker({Key key, this.provider}) : super(key: key);
  final ClaimsProvider provider;

  Future<void> _pickFile(String fileName) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path);
      fileName = path.basename(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (context, pr, child) => TextFormField(
        controller: TextEditingController(text: pr.fileName),
        readOnly: true,
        decoration: InputDecoration(
            hintText: 'Upload any files',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: MColors.textFieldBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: MColors.textFieldBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: MColors.textFieldBorder),
            ),
            prefixIcon: InkWell(
              onTap: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.single.path);
                  pr.fileName = path.basename(file.path);
                }
              },
              child: Icon(Icons.cloud_upload_rounded),
            )),
        onChanged: (value) {
          pr.fileName = value;
        },
      ),
    );
  }
}
