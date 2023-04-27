import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:Cliamizer/generated/l10n.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../res/gaps.dart';

class NoDataWidgetGrid extends StatelessWidget {
  final Function onRefresh;

  const NoDataWidgetGrid({
    Key key,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20),
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 36.w,
              width: 36.w,
              child: SvgPicture.asset(
                ImageUtils.getSVGPath("no_search_result"),
                fit: BoxFit.contain,
              )),
          SizedBox(height: 2.w),
          Text(
            S.of(context).noResults,
            style: MTextStyles.textDark14,
          ),
          Gaps.vGap6,
          InkWell(
            onTap: onRefresh ?? () async {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.5.w,vertical: 1.w),
                decoration: BoxDecoration(
                  color: MColors.primary_color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(S.of(context).refresh)),
          )
        ],
      ),
    );
  }
}
