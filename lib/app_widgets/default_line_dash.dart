import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/colors.dart';

class DefaultDashLine extends StatelessWidget {
  const DefaultDashLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 1.0;
        final dashHeight = .8.h;
        final dashCount = 4;
        return Column(
          children: List.generate(dashCount, (index) {
            return Container(
              width: dashWidth,
              height: index%2 == 0? 1.5.h:dashHeight,
              margin: EdgeInsets.only(bottom: 1.h),
              child: DecoratedBox(
                decoration: BoxDecoration(color: MColors.gray_9a,
                borderRadius: BorderRadius.circular(10)),
              ),
            );
          }),
        );
      },
    );
  }
}
