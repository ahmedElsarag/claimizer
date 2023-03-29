import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';

class RememberThatItem extends StatelessWidget {
  const RememberThatItem({Key key, @required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: 20.h,
      padding: EdgeInsets.all(16),
      margin: EdgeInsetsDirectional.only(start: index == 0 ? 20 : 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(200), color: Colors.blue.withOpacity(.2)),
                  child: SvgPicture.asset(
                    ImageUtils.getSVGPath('remember'),
                    width: 16,
                    height: 16,
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                    S.of(context).youNeedToRenewTheContract,
                maxLines: 2,
                style: TextStyle(color: Colors.black.withOpacity(.8), fontSize: 10.sp, fontWeight: FontWeight.w500),
              )),
              SvgPicture.asset(
                ImageUtils.getSVGPath('alert'),
                width: 16,
                height: 16,
              )
            ],
          ),
          Gaps.vGap5,
          Divider(
            color: MColors.dividerColor,
          ),
          Gaps.vGap5,
          Text(S.of(context).youNeedToRenewTheContractYouNeedToRenew,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 9.sp,
              )),
        ],
      ),
    );
  }
}
