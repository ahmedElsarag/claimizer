import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key key, this.value}) : super(key: key);
 final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.description,
            style: MTextStyles.textMain16.copyWith(
              color: MColors.black,
            )),
        Gaps.vGap8,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: MColors.outlineBorderLight
            ),
            borderRadius: BorderRadius.circular(8)
          ),
          padding: EdgeInsets.symmetric(vertical: 4.w,horizontal: 6.w),
          child: Text(value,
              style: MTextStyles.textMain14.copyWith(
                color: MColors.primary_light_color,
                fontWeight: FontWeight.w400,
              )),
        ),
        Gaps.vGap12,
        Gaps.vGap12,
      ],
    );
  }
}
