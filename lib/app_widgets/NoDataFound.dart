import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:Cliamizer/generated/l10n.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20),
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: MColors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 50.w,
              width: 60.w,
              child: SvgPicture.asset(
               ImageUtils.getSVGPath("no_search_result"),
              )),
          SizedBox(height: 20),
          Text(
            S.of(context).noResults,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: MColors.black),
          ),
          SizedBox(height: 20),
          Text(
            S.of(context).sorryThereAreNoResultsForThisSearchPleaseTry,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: MColors.primary_light_color),
          ),
          // SpinKitSpinningLines(
          //     color: MColors.gray_99.withOpacity(.5)),
        ],
      ),
    );
  }
}
