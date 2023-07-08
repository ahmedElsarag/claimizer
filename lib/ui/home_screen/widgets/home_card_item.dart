import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../res/colors.dart';

class HomeCardItem extends StatelessWidget {
  const HomeCardItem(
      {Key key, @required this.cardColor, @required this.title, @required this.imageIcon, @required this.value})
      : super(key: key);

  final Color cardColor;
  final String title;
  final String imageIcon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 22.h,
      // margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: cardColor.withOpacity(.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AutoSizeText(
                value,
                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),maxLines: 1,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: cardColor.withOpacity(.15)),
                child: SvgPicture.asset(
                  ImageUtils.getSVGPath(imageIcon),
                  width: 3.w,
                  height: 3.w,
                ),
              )
            ],
          ),
          Spacer(),
          AutoSizeText(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, color: MColors.black),
          ),
        ],
      ),
    );
  }
}
