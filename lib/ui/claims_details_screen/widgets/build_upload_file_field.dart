import 'dart:io';

import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class BuildUploadFileField extends StatefulWidget {
  BuildUploadFileField({Key key, this.provider}) : super(key: key);
  ClaimsDetailsProvider provider;

  @override
  State<BuildUploadFileField> createState() => _BuildUploadFileFieldState();
}

class _BuildUploadFileFieldState extends State<BuildUploadFileField> {
  final picker = ImagePicker();

  @override
  void initState() {
    widget.provider = context.read<ClaimsDetailsProvider>();
    super.initState();
  }

  List<XFile> _imageFiles;

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        // widget.provider.file.path = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _imageFiles = pickedFiles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsDetailsProvider>(
      builder: (context, pr, child) => GestureDetector(
          onTap: () async {
            // final result = await FilePicker.platform.pickFiles(
            //   allowMultiple: true,
            //   type: FileType.image
            // );
            // if (result != null) {
            //   final file = File(result.files.single.path);
            //   print("##################### ${result.files.single.path}");
            //   pr.updateCommentFile(file);
            //   print("##################### ${pr.file.path}");
            // }
            // print("##################### ${pr.file.path}");
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: MColors.textFieldBorder), borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SvgPicture.asset(ImageUtils.getSVGPath("file_upload")),
                Gaps.hGap8,
                SizedBox(
                  width: 35.w,
                  child: Text(
                    pr.file != null ? pr.file.path : S.current.uploadAnyFiles,
                    style: MTextStyles.textDark14,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    pr.updateCommentFile(null);
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
          )
          /*TextFormField(
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

        ),*/
          ),
    );
  }
}
