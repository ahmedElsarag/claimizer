import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class FilesWidget extends StatelessWidget {
 final String value;

  const FilesWidget({Key key, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).allAttachment,
            style: MTextStyles.textMain16.copyWith(
              color: MColors.black,
            )),
        Gaps.vGap12,
        SizedBox(
          height: 74,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
            child: Image.asset(value),
          ),),
        ),
        Gaps.vGap12,
        Gaps.vGap12,
      ],
    );
  }
}
