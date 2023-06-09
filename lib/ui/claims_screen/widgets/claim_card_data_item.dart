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
          AutoSizeText(
            title + ":  ",
            style: TextStyle(color: MColors.subtitlesColor, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: Utils.sWidth(30, context),
            child: AutoSizeText(
              data ?? "",
              style: TextStyle(color: MColors.subText_color),
            ),
          )
        ],
      ),
    );
  }
}
