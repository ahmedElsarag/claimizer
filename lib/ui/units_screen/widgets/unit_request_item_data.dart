import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../CommonUtils/utils.dart';
import '../../../res/colors.dart';

class UnitRequestDataItem extends StatelessWidget {
  const UnitRequestDataItem({Key key, this.title, this.data, this.isLast = false}) : super(key: key);

  final String title;
  final String data;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8.0),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            title + ":  ",
            style: TextStyle(color: MColors.subtitlesColor, fontWeight: FontWeight.w700),
          ),
          // Spacer(),
          SizedBox(
            width: Utils.sWidth(45, context),
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
