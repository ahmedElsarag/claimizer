import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/units_screen/units_presenter.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class ExistingUnitList extends StatelessWidget {
  const ExistingUnitList({Key key, this.presenter}) : super(key: key);
  final UnitPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) {
        print("@@@@@@@@@@@@@@@@@@@ : ${pr.unitsList.length}");
        return pr.unitsList.isNotEmpty ? RefreshIndicator(
          onRefresh: () async {
            pr.searchController.clear();
            await presenter.getExistingUnitsApiCall();
          },
          child: ListView.builder(
            itemCount: pr.unitsList.length,
            itemBuilder: (context, index) =>
                Container(
                  decoration:
                  BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
                  margin: index == 0 ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 2.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pr.unitsList[index].name ?? "",
                                style: MTextStyles.textBoldDark16,
                              ),
                              Text(
                                S
                                    .of(context)
                                    .requestCode + pr.unitsList[index].code,
                                style: MTextStyles.textSubtitle,
                              ),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color(0xff44A4F2).withOpacity(0.08),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Text("New" ?? '',
                                  style: MTextStyles.textDark12.copyWith(
                                      color: MColors.blueButtonColor, fontWeight: FontWeight.w600)))
                        ],
                      ),
                      buildDivider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .unitName,
                                style: MTextStyles.textBoldDark12
                                    .copyWith(color: MColors.subtitlesColor),
                              ),
                              Text(
                                pr.unitsList[index].name ?? "",
                                style: MTextStyles.textSubtitle,
                              ),
                            ],
                          ),
                          Gaps.vGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .buildingName,
                                style: MTextStyles.textBoldDark12
                                    .copyWith(color: MColors.subtitlesColor),
                              ),
                              Text(
                                pr.unitsList[index].building ?? "",
                                style: MTextStyles.textSubtitle,
                              ),
                            ],
                          ),
                          Gaps.vGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .unitType,
                                style: MTextStyles.textBoldDark12
                                    .copyWith(color: MColors.subtitlesColor),
                              ),
                              Text(
                                pr.unitsList[index].type ?? "",
                                style: MTextStyles.textSubtitle,
                              ),
                            ],
                          ),
                          Gaps.vGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .company,
                                style: MTextStyles.textBoldDark12
                                    .copyWith(color: MColors.subtitlesColor),
                              ),
                              Text(
                                pr.unitsList[index].company ?? "",
                                style: MTextStyles.textSubtitle,
                              ),
                            ],
                          ),
                          Gaps.vGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .contractNo,
                                style: MTextStyles.textBoldDark12
                                    .copyWith(color: MColors.subtitlesColor),
                              ),
                              Text(
                                pr.unitsList[index].id.toString() ?? "",
                                style: MTextStyles.textSubtitle,
                              ),
                            ],
                          ),
                          Gaps.vGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .startAt,
                                style: MTextStyles.textBoldDark12
                                    .copyWith(color: MColors.subtitlesColor),
                              ),
                              Text(
                                pr.unitsList[index].startAt ?? "",
                                style: MTextStyles.textSubtitle,
                              ),
                            ],
                          ),
                          Gaps.vGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .endAt,
                                style: MTextStyles.textBoldDark12
                                    .copyWith(color: MColors.subtitlesColor),
                              ),
                              Text(
                                pr.unitsList[index].endAt ?? "",
                                style: MTextStyles.textSubtitle,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          ),
        ) : NoDataWidget(
          onRefresh: ()async{
            await presenter.getExistingUnitsApiCall();
          },
        );
      },
    );
  }

  Column buildDivider() {
    return Column(
      children: [
        Gaps.vGap16,
        Divider(
          color: MColors.dividerColor,
        ),
        Gaps.vGap16,
      ],
    );
  }

}
