import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';
import '../UnitDetailsPresenter.dart';
import '../UnitDetailsProvider.dart';

class BuildUploadFileField extends StatefulWidget {
  BuildUploadFileField({Key key, this.provider,this.presenter}) : super(key: key);
  UnitDetailsProvider provider;
  UnitDetailsPresenter presenter;

  @override
  State<BuildUploadFileField> createState() => _BuildUploadFileFieldState();
}

class _BuildUploadFileFieldState extends State<BuildUploadFileField> {
  final picker = ImagePicker();

  @override
  void initState() {
    widget.provider = context.read<UnitDetailsProvider>();
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
    return Consumer<UnitDetailsProvider>(
      builder: (context, pr, child) => GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.all(16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60.w,
                        child: ElevatedButton.icon(
                          onPressed: getImageFromCamera,
                          icon: Icon(Icons.camera_alt, color: MColors.text_button_color),
                          label: FittedBox(
                            child: Text(S.of(context).takePhoto,
                                style: MTextStyles.textMain12.copyWith(color: MColors.text_button_color)),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 60.w,
                        child: ElevatedButton.icon(
                          onPressed: pickImages,
                          icon: Icon(Icons.photo_library, color: MColors.text_button_color),
                          label: FittedBox(
                            child: Text(
                              S.of(context).chooseFromGallery,
                              style: MTextStyles.textMain12.copyWith(color: MColors.text_button_color),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: MColors.textFieldBorder), borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                      color: MColors.rejected_color,
                    ),
                    Text(pr.imageFiles.length.toString() + " " + S.of(context).images)
                  ],
                )
                    :  Column(
                  children: [
                    SvgPicture.asset(ImageUtils.getSVGPath("file_upload"),
                        color: MColors.light_text_color),
                    Gaps.vGap8,
                    Text(
                      S.of(context).uploadAnyFiles,
                      style: MTextStyles.textMain14.copyWith(color: MColors.light_text_color),
                    ),
                  ],
                ),
                // Spacer(),
                Visibility(
                  visible: pr.imageFiles != null || pr.file != null,
                  child: InkWell(
                    onTap: () async {
                      pr.imageFiles = null;
                      pr.file = null;
                      setState(() {});
                    },
                    child: Icon(Icons.close),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
