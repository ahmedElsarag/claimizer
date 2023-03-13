import 'package:flutter/material.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:sizer/sizer.dart';

class HeadLine extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  final bool isSuffix;
  final String multiText;
  final bool multiPrefix;
  final Function suffixPressed;
  final EdgeInsets padding;

  HeadLine({
    this.prefixText,
    this.suffixText,
    this.multiText,
    this.isSuffix = true,
    this.multiPrefix = false,
    this.suffixPressed,
    this.textStyle, this.padding,
  });

  TextStyle textStyle = TextStyle(
      color: MColors.font_color, fontSize: 14.sp, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prefixText,
                style: textStyle??TextStyle(color: MColors.white5.withOpacity(.8),fontWeight: FontWeight.w600)
              ),
              multiPrefix
                  ? Text(
                      multiText,
                      style: TextStyle(color: MColors.hint_color,fontSize: 10.sp),
                    )
                  : Container()
            ],
          ),
          isSuffix
              ? GestureDetector(
                  onTap: suffixPressed,
                  child: Row(
                    children: [
                      Text(
                        suffixText,
                        style: TextStyle(
                            color: MColors.yellow,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 4,),
                      Icon(Icons.arrow_forward_ios_rounded,color: MColors.yellow,size: 14.sp,)
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
