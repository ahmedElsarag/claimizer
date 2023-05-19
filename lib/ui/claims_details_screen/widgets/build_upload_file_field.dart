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

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: MColors.error_color,
          margin: EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
          content: Text(S.of(context).only4ImagesAllowed)));
      Navigator.pop(context);
      Navigator.pop(context);
      return ;
    }
    if (pickedFiles != null) {
      setState(() {
        widget.provider.imageFiles = pickedFiles;
      });
    }
    Navigator.pop(context);
  }

  // File pr.file;

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        widget.provider.file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsDetailsProvider>(
      builder: (context, pr, child) => GestureDetector(
          onTap: () async {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60.w,
                      child: ElevatedButton.icon(
                        onPressed: getImageFromCamera,
                        icon: Icon(Icons.camera_alt, color: MColors.text_button_color),
                        label: Text(S.of(context).takePhoto,
                            style: MTextStyles.textMain14.copyWith(color: MColors.text_button_color)),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 60.w,
                      child: ElevatedButton.icon(
                        onPressed: pickImages,
                        icon: Icon(Icons.photo_library, color: MColors.text_button_color),
                        label: Text(
                          S.of(context).chooseFromGallery,
                          style: MTextStyles.textMain14.copyWith(color: MColors.text_button_color),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },);

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
                border: Border.all(color: MColors.textFieldBorder),
                borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SvgPicture.asset(ImageUtils.getSVGPath("file_upload")),
                Gaps.hGap8,
                SizedBox(
                  width: 35.w,
                  child: Text(
                    pr.file!= null ? pr.file.path : pr.imageFiles !=null? pr.imageFiles[0].path: S.current.uploadAnyFiles,
                    style: MTextStyles.textDark14,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    pr.imageFiles=null;
                    pr.file=null;
                    setState(() {});
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
          )),
    );
  }
}
