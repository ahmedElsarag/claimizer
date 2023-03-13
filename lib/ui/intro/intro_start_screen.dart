import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Cliamizer/ui/intro/IntroScreen.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../res/colors.dart';
import 'widgets/intro_page.dart';

class IntroStartScreen extends StatefulWidget {

  @override
  IntroStartScreenState createState() => IntroStartScreenState();
}

class IntroStartScreenState extends State<IntroStartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          MColors.primary_color.withOpacity(.94),
          MColors.primary_light_color.withOpacity(.9),
        ])),
        child: Column(
          children: <Widget>[
            Container(
              height: 55.h,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    child: SvgPicture.asset(
                      'assets/images/svg/sh.svg',
                      width: 100.w,
                      height: 55.h,
                    ),
                  ),
                  Positioned(
                    left: 20.w,
                    top: 7.h,
                    child: Hero(tag: 'logo1', child: SvgPicture.asset('assets/images/svg/logo.svg', width: 90)),
                  ),
                  Positioned.fill(
                    child: Container(
                      margin: EdgeInsets.only(top: 6.h),
                      child: Image.asset(
                        'assets/images/svg/pics.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 25.h,
                      child: WelcomeMessageWidget(
                        introText: S.of(context).intro_text_1,
                      )),
                  GestureDetector(
                    child: Container(
                      width: 100.w,
                      height: 6.h,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: MColors.btn_color,
                      ),
                      child: Center(
                        child: Text(
                          'Get Start',
                          style:
                              TextStyle(color: MColors.primary_text_color, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontSize: 11.sp),
                        ),
                      ),
                    ),
                    onTap: () {
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => IntroScreen()));
                    },
                  ),
                ],
              ),
            ),
          ],
          // onPageChanged: onChangedFunction,
        ),
      ),
    );
  }
}
