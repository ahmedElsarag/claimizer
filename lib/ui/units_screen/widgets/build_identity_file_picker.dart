import 'dart:io';

import 'package:Cliamizer/CommonUtils/FullScreenImage.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
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

class BuildIdentityFilePicker extends StatefulWidget {
  BuildIdentityFilePicker({Key key, this.provider}) : super(key: key);
  UnitProvider provider;

  @override
  State<BuildIdentityFilePicker> createState() => _BuildIdentityFilePickerState();
}

class _BuildIdentityFilePickerState extends State<BuildIdentityFilePicker> {
  final picker = ImagePicker();

  @override
  void initState() {
    widget.provider = context.read<UnitProvider>();
    super.initState();
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        widget.provider.identityImg = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        widget.provider.identityImg = File(pickedFile.path);
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
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.all(20),
                  contentPadding: EdgeInsets.all(16),
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
                          onPressed: pickImageFromGallery,
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
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: MColors.textFieldBorder), borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SvgPicture.asset(ImageUtils.getSVGPath("file_upload")),
                Gaps.hGap8,
                pr.identityImg != null
                    ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(pr.identityImg,width: 10.w,height: 10.w,fit: BoxFit.cover,))
                    : Text(
                        S.of(context).uploadYourIdentity,
                        style: MTextStyles.textDark14,
                      ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    pr.identityFiles = null;
                    pr.identityImg = null;
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
