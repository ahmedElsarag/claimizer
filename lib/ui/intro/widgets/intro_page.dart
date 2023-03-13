import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../res/colors.dart';

class WelcomeMessageWidget extends StatelessWidget {

  final String introText;

  const WelcomeMessageWidget({this.introText});


  @override
  Widget build(BuildContext context) {

    return Column(children: <Widget>[
      SvgPicture.asset('assets/images/svg/welcom_logo.svg'),
      SizedBox(height: 1.5.h,),
      Text(
        introText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13.sp,
          color: MColors.white5 ,
          fontWeight: FontWeight.w500,
        ),
      )
    ]);
  }
}
