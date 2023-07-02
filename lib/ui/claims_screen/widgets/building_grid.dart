import 'package:Cliamizer/ui/claims_screen/ClaimsPresenter.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../app_widgets/NoDataFoundGrid.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class BuildingGrid extends StatelessWidget {
  const BuildingGrid({Key key, this.onSelected, this.presenter}) : super(key: key);
  final Function(int) onSelected;
  final ClaimsPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsWithFilterProvider>(
      builder: (ctx, pr, w) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 1.w,
                height: 5.w,
                margin: EdgeInsetsDirectional.only(end: 3.w),
                decoration:
                    BoxDecoration(color: MColors.primary_verticalHeader, borderRadius: BorderRadius.circular(4)),
              ),
              SvgPicture.asset(
                ImageUtils.getSVGPath("buildings"),
                color: MColors.primary_color,
              ),
              Gaps.hGap8,
              Text(S.of(context).selectBuilding, style: MTextStyles.textMain16),
            ],
          ),
          pr.buildingsList.isNotEmpty? GridView.builder(
            itemCount: pr.buildingsList.length,
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
                  pr.selectedBuildingIndex = index;
                        onSelected(pr.buildingsList[index].id);
                        pr.selectedBuilding = pr.buildingsList[index].name;
                        Future.delayed(Duration(seconds: 0));
                        pr.currentStep < 2 ? pr.currentStep += 1 : null;
                      },
                child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: pr.selectedBuildingIndex == index ? MColors.primary_color : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: MColors.dividerColor.withOpacity(.6), width: 2)),
                  child: Text(
                    pr.buildingsList[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: pr.selectedBuildingIndex == index ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ) : NoDataWidgetGrid(
            onRefresh: ()async{
              presenter.getBuildingsApiCall();
            },
          ),
        ],
      ),
    );
  }
}
