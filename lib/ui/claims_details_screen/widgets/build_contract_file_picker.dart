import 'dart:io';

import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsProvider.dart';
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

class BuildUploadFileField extends StatelessWidget {
  const BuildUploadFileField({Key key, this.provider}) : super(key: key);
  final ClaimsDetailsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsDetailsProvider>(
      builder: (context, pr, child) => InkWell(
        onTap: () async {
          final result = await FilePicker.platform.pickFiles();
          if (result != null) {
            final file = File(result.files.single.path);
            pr.updateCommentFile(file);
          }
        },
        child: TextFormField(
          style: MTextStyles.textDark14,
          readOnly: true,
          controller: TextEditingController(text: pr?.file?.path),
          // initialValue: pr.contractImg.path,
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
                 pr.updateCommentFile(null);
                },
                child:Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.close),
                ),
              ),
              prefixIcon: InkWell(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    final file = File(result.files.single.path);
                    pr.updateCommentFile(file);
                  }
                },
                child:Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(ImageUtils.getSVGPath("file_upload")),
                ),
              )),

        ),
      ),
    );
  }
}
