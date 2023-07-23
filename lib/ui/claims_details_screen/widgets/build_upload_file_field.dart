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
      return;
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MColors.error_color,
            margin: EdgeInsets.all(8),
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).noImageSelected)));
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsDetailsProvider>(
      builder: (context, pr, child) => GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.all(14),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(S.of(context).uploadImageFrom,
                          style: MTextStyles.textMain14.copyWith(color: MColors.primary_text_color)),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: getImageFromCamera,
                            child: Container(
                              width: 40.w,
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: MColors.primary_color.withOpacity(.1),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.camera_alt, color: MColors.primary_color),
                                  Gaps.vGap6,
                                  FittedBox(
                                    child: Text(S.of(context).takePhoto,
                                        style: MTextStyles.textMain12.copyWith(color: MColors.primary_color)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: pickImages,
                            child: Container(
                              width: 40.w,
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  color: MColors.primary_color.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.photo_library, color: MColors.primary_color),
                                  Gaps.vGap6,
                                  FittedBox(
                                    child: Text(S.of(context).fromGallery,
                                        style: MTextStyles.textMain12.copyWith(color: MColors.primary_color)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: MColors.primary_color.withOpacity(.1),
              borderRadius: BorderRadius.circular(8)
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                pr.file != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          pr.file,
                          width: 10.w,
                          height: 10.w,
                          fit: BoxFit.cover,
                        ))
                    : pr.imageFiles != null
                        ? Row(
                            children: [
                              Icon(
                                Icons.image,
                                color: MColors.primary_color,
                              ),
                              Gaps.hGap10,
                              Text(pr.imageFiles.length.toString() + " " + S.of(context).images)
                            ],
                          )
                        : Row(

                            children: [
                              SvgPicture.asset(ImageUtils.getSVGPath("file_upload"),
                                  color: MColors.light_text_color),
                              Gaps.hGap10,
                              Text(
                                S.of(context).uploadAnyFiles,
                                style: MTextStyles.textMain14.copyWith(color: MColors.light_text_color),
                              ),
                            ],
                          ),
                Spacer(),
                Visibility(
                  visible: pr.imageFiles != null || pr.file != null,
                  child: InkWell(
                    onTap: () async {
                      pr.imageFiles = null;
                      pr.file = null;
                      setState(() {});
                    },
                    child: Icon(Icons.close,color: MColors.rejected_color,),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
