import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/styles.dart';

class ClaimCardDataItem extends StatelessWidget {
  const ClaimCardDataItem({Key key, this.title, this.data, this.isLast = false}) : super(key: key);

  final String title;
  final String data;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title + " :  ",
            style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
          ),
          // SizedBox(
          //   width: 20,
          // ),
          Container(
              // width: 40.w,
              alignment: AlignmentDirectional.centerEnd,
              child: SizedBox(
                width: Utils.sWidth(35, context),
                child: AutoSizeText(
                  data.toLowerCase() ?? S.of(context).na,
                  maxLines: 2,
                  style: MTextStyles.textSubtitle,
                ),
              )),
        ],
      ),
    );
  }
}
