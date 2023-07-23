import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/styles.dart';

class UnitCardItem extends StatelessWidget {
  const UnitCardItem({Key key, this.title, this.data, this.isLast = false}) : super(key: key);

  final String title;
  final String data;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Utils.sWidth(35, context),
            child: AutoSizeText(
              title,
              maxFontSize: 12,
              maxLines: 2,
              style: TextStyle(color: MColors.subtitlesColor, fontWeight: FontWeight.w700),
            ),
          ),
          // Spacer(),
          SizedBox(
            width: Utils.sWidth(47, context),
            child: AutoSizeText(
              data ?? "",
              textAlign: TextAlign.end,
              maxLines: 2,
              maxFontSize: 12,
              style: TextStyle(color: MColors.subText_color),
            ),
          )
        ],
      ),
    );
  }
}
