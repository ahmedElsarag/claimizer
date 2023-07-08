import 'package:Cliamizer/app_widgets/claimizer_app_bar.dart';
import 'package:Cliamizer/app_widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../res/colors.dart';
import '../res/setting.dart';
import 'image_utils.dart';

class FullScreenImage extends StatelessWidget {
  final String image;

  const FullScreenImage({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.w),
              child: AppBar(
                backgroundColor: MColors.white,
                title: Text(""),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Setting.mobileLanguage.value != Locale("en")
                          ? RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          ImageUtils.getSVGPath("back_icon"),
                        ),
                      )
                          : SvgPicture.asset(
                        ImageUtils.getSVGPath("back_icon"),
                      )),
                ),
              ),
            ),
            Expanded(
              child: ImageLoader(imageUrl: image),
            ),
          ],
        ),
      ),
    );
  }
}