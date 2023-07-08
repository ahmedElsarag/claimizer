import 'package:Cliamizer/CommonUtils/utils.dart';
import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/home_screen/HomeProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_presenter.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:Cliamizer/ui/units_screen/widgets/unit_request_item_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';
import '../../unit_request_details_screen/UnitDetailsScreen.dart';

class UnitLinkRequest extends StatelessWidget {
  const UnitLinkRequest({Key key, this.presenter, this.homeProvider}) : super(key: key);
  final UnitPresenter presenter;
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => pr.unitsRequestList.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () async {
                await presenter.getUnitRequestsApiCall();
                pr.unitLinkSearchController.clear();
              },
              child: ListView.builder(
                itemCount: pr.unitsRequestList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => UnitRequestDetailsScreen(
                            id: pr.unitsRequestList[index].id,
                            unitRequestDataBean: pr.unitsRequestList[index],
                          ),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
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
                                AutoSizeText(
                                  pr.unitsRequestList[index].unitName ?? "",
                                  style: TextStyle(color: MColors.text_dark, fontWeight: FontWeight.bold),
                                ),
                                AutoSizeText(
                                  S.of(context).unitRequestCode + "\n" + pr.unitsRequestList[index].refCode,
                                  style: TextStyle(fontWeight: FontWeight.w500, color: MColors.subText_color),
                                ),
                              ],
                            ),
                            Card(
                              color: presenter
                                  .getUnitStatusColorFromString(pr?.unitsRequestList[index]?.status?.toLowerCase()),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                child: AutoSizeText(
                                  pr?.unitsRequestList[index]?.status ?? '',
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        buildDivider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UnitRequestDataItem(
                              title: S.of(context).unitName,
                              data: pr.unitsRequestList[index].unitName,
                              isLast: true,
                            ),
                            Gaps.vGap8,
                            UnitRequestDataItem(
                              title: S.of(context).buildingName,
                              data: pr.unitsRequestList[index].buildingName,
                              isLast: true,
                            ),
                            Gaps.vGap8,
                            UnitRequestDataItem(
                              title: S.of(context).unitType,
                              data: pr.unitsRequestList[index].unitType,
                              isLast: true,
                            ),
                            Gaps.vGap8,
                            UnitRequestDataItem(
                              title: S.of(context).company,
                              data: pr.unitsRequestList[index].company,
                              isLast: true,
                            ),
                            Gaps.vGap8,
                            UnitRequestDataItem(
                              title: S.of(context).contractNo,
                              data: pr.unitsRequestList[index].contractNumber,
                              isLast: true,
                            ),
                            Gaps.vGap8,
                            UnitRequestDataItem(
                              title: S.of(context).startAt,
                              data: pr.unitsRequestList[index].startAt,
                              isLast: true,
                            ),
                            Gaps.vGap8,
                            UnitRequestDataItem(
                              title: S.of(context).endAt,
                              data: pr.unitsRequestList[index].endAt,
                              isLast: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : NoDataWidget(onRefresh: () async {
              await presenter.getUnitRequestsApiCall();
            }),
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
