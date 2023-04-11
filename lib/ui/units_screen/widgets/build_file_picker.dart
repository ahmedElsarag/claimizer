import 'dart:io';

import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../../../CommonUtils/image_utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/styles.dart';

class BuildFilePicker extends StatelessWidget {
  const BuildFilePicker({Key key, this.provider}) : super(key: key);
  final UnitProvider provider;

  Future<void> _pickFile(String fileName) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path);
      fileName = path.basename(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => TextFormField(
        controller: TextEditingController(text: pr.fileName),
        style: MTextStyles.textDark14,
        readOnly: true,
        decoration: InputDecoration(
            hintText: S.of(context).uploadAnyFiles,
            hintStyle: MTextStyles.textMain14,
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
            suffixIcon:  InkWell(
              onTap: () async {
               pr.fileName = null;
              },
              child:Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.close),
              ),
            ),
            prefixIcon: InkWell(
              onTap: () async {
                FilePickerResult result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.single.path);
                  pr.fileName = path.basename(file.path);
                }
              },
              child:Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(ImageUtils.getSVGPath("file_upload")),
              ),
            )),

      ),
    );
  }
}
