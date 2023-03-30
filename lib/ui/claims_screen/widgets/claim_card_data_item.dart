import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
          ),
          Text(
            data ?? S.of(context).na,
            style: MTextStyles.textSubtitle,
          ),
        ],
      ),
    );
  }
}
