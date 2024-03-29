import 'dart:io';

import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class BuildFilePicker extends StatefulWidget {
  const BuildFilePicker({Key key, this.provider}) : super(key: key);
  final ClaimsProvider provider;

  @override
  State<BuildFilePicker> createState() => _BuildFilePickerState();
}

class _BuildFilePickerState extends State<BuildFilePicker> {
  final picker = ImagePicker();

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MColors.error_color,
            margin: EdgeInsets.all(8),
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).only4ImagesAllowed)));
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (context, pr, child) => GestureDetector(
          onTap: () async {
            showDialog(context: context, builder: (context) {
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
            },);
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
                pr.file != null
                    ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(pr.file,width: 10.w, height: 10.w,fit: BoxFit.cover,))
                    : pr.imageFiles != null&&pr.imageFiles.isNotEmpty
                    ? Row(
                  children: [Icon(Icons.image,color: MColors.rejected_color,), Text(pr.imageFiles.length.toString() +" "+ S.of(context).images)],
                )
                    : Text(
                  S.current.uploadAnyFiles,
                  style: MTextStyles.textDark14,
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
