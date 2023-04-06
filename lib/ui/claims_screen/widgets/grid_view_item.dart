import 'dart:ffi';

import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../app_widgets/app_headline.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class StepWidget extends StatelessWidget {
  StepWidget(
      {Key key,
      this.provider,
      this.itemsList,
      this.selectedItemIndex,
      this.selectedItem,
      this.step,
      this.stepCount,
      this.stepCountCompare})
      : super(key: key);
  final ClaimsProvider provider;
  final List<dynamic> itemsList;
  int selectedItemIndex;
  String selectedItem;
  int step;
  int stepCountCompare;
  int stepCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 1.w,
              height: 5.w,
              margin: EdgeInsetsDirectional.only(end: 3.w),
              decoration: BoxDecoration(
                  color: MColors.primary_verticalHeader,
                  borderRadius: BorderRadius.circular(4)),
            ),
            SvgPicture.asset(
              ImageUtils.getSVGPath("buildings"),
              color: MColors.primary_color,
            ),
            Gaps.hGap8,
            Text(S.of(context).selectBuilding, style: MTextStyles.textMain16),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GridView.builder(
            controller: provider.scrollController,
            itemCount: itemsList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  selectedItemIndex = index;
                  selectedItem = itemsList[index];
                  Future.delayed(Duration(seconds: 0));
                  step < stepCountCompare ? step += stepCount : null;
                  print(
                      "selectedIndex $selectedItemIndex, selectedItem $selectedItem, stepCount $stepCount, stepCompare $stepCountCompare");
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: selectedItemIndex == index
                          ? MColors.primary_color
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: MColors.dividerColor.withOpacity(.6),
                          width: 2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageUtils.getSVGPath("unlink_2_fill")),
                      Gaps.vGap8,
                      Text(
                        itemsList[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: selectedItemIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
