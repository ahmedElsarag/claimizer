import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/home_screen/HomeProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_presenter.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/utils.dart';
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
      builder: (context, pr, child) =>  pr.unitsRequestList.isNotEmpty? RefreshIndicator(
        onRefresh: ()async{
          await presenter.getUnitRequestsApiCall();
        },
        child: ListView.builder(
          itemCount: pr.unitsRequestList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& ${pr.unitsRequestList[index].id}");
              Navigator.push(context, CupertinoPageRoute(builder: (context) => UnitRequestDetailsScreen(
                id: pr.unitsRequestList[index].id,
                unitRequestDataBean: pr.unitsRequestList[index],
              ),));
            },
            child: Container(
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
                            pr.unitsRequestList[index].unitName??"",
                            style: MTextStyles.textBoldDark16,
                          ),
                          Text(
                            S.of(context).requestCode + pr.unitsRequestList[index].refCode,
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Utils.getUnitStatusColorFromString(pr?.unitsRequestList[index]?.status),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text(pr.unitsRequestList[index].status ?? '',
                              style: MTextStyles.textDark12.copyWith(
                                  color: Utils.getTextStatusColorFromString(pr?.unitsRequestList[index]?.status), fontWeight: FontWeight.w600)))
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
                            S.of(context).unitName,
                            style: MTextStyles.textBoldDark12
                                .copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            pr.unitsRequestList[index].unitName??"",
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).buildingName,
                            style: MTextStyles.textBoldDark12
                                .copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            pr.unitsRequestList[index].buildingName??"",
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).unitType,
                            style: MTextStyles.textBoldDark12
                                .copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            pr.unitsRequestList[index].unitType??"",
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).company,
                            style: MTextStyles.textBoldDark12
                                .copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            pr.unitsRequestList[index].company??"",
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).contractNo,
                            style: MTextStyles.textBoldDark12
                                .copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            pr.unitsRequestList[index].contractNumber ?? S.current.na,
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).startAt,
                            style: MTextStyles.textBoldDark12
                                .copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            pr.unitsRequestList[index].startAt??"",
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).endAt,
                            style: MTextStyles.textBoldDark12
                                .copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            pr.unitsRequestList[index].endAt??"",
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  /*buildDivider(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: MColors.primary_color.withOpacity(0.08),
                                  shape: BoxShape.circle
                              ),
                              padding: EdgeInsets.all(8),
                              child: SvgPicture.asset(ImageUtils.getSVGPath("comment"))),
                          Gaps.hGap8,
                          Text(S.of(context).comment,style: MTextStyles.textMain14,)
                        ],
                      ),
                      Gaps.hGap15,
                      Gaps.hGap15,
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: MColors.primary_color.withOpacity(0.08),
                                  shape: BoxShape.circle
                              ),
                              padding: EdgeInsets.all(8),
                              child: SvgPicture.asset(ImageUtils.getSVGPath("reply"))),
                          Gaps.hGap8,
                          Text(S.of(context).reply,style: MTextStyles.textMain14,)
                        ],
                      )
                    ],
                  )*/
                ],
              ),
            ),
          ),
        ),
      )
    : NoDataWidget(
      onRefresh: ()async{
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
