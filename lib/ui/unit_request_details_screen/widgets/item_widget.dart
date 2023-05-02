import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key key, this.title, this.value, this.valueColor}) : super(key: key);
 final String title;
 final String value;
 final Color valueColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: MTextStyles.textMain16.copyWith(
              color: MColors.black,
            )),
        Gaps.vGap8,
        Text(value,
            style: MTextStyles.textMain14.copyWith(
              color: valueColor ?? MColors.black,
              fontWeight: FontWeight.w400,
            )),
        Gaps.vGap12,
        Gaps.vGap12,
      ],
    );
  }
}
