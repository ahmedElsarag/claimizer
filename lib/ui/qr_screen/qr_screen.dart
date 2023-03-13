import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/TextWidgets.dart';
import 'package:Cliamizer/ui/qr_screen/widgets/qr_card.dart';

import '../../res/colors.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.secondary_color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(ImageUtils.getImagePath('qr_shape'),fit: BoxFit.fill,height:35.h,width: double.maxFinite),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 40),
                  child: SvgPicture.asset(ImageUtils.getSVGPath('qr'),height: 30.h),
                )
              ],
            ),
            SizedBox(height: 2.h,),
            boldText('QR Code Scanner',fontSize: 16.sp,color: MColors.white5.withOpacity(.8)),
            SizedBox(height: 4.h,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  QrCard(imagePath: 'qr_scanner', title: 'QR SCANNER'),
                  QrCard(imagePath: 'card_scan', title: 'CARD SCAN'),
                  QrCard(imagePath: 'polices', title: 'POLICIES'),
                  QrCard(imagePath: 'games', title: 'GAMES'),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}