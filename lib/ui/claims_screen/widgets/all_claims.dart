import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsPresenter.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/claim_card_data_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class AllClaims extends StatelessWidget {
  const AllClaims({Key key, this.presenter}) : super(key: key);

  final ClaimsPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (ctx, pr, w) => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: pr.claimsList.isNotEmpty
            ? ListView.separated(
                shrinkWrap: true,
                itemCount: pr.claimsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                    margin:
                        EdgeInsets.only(top: index == 0 ? 20 : 0, bottom: index == pr.claimsList.length - 1 ? 20 : 0),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pr?.claimsList[index]?.unit?.building ?? S.current.na,
                                  style: MTextStyles.textBoldDark16,
                                ),
                                Text(
                                  S.of(context).requestCode + " ${pr?.claimsList[index]?.referenceId}",
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
                                child: Text(pr?.claimsList[index]?.status ?? '',
                                    style: MTextStyles.textDark12
                                        .copyWith(color: MColors.blueButtonColor, fontWeight: FontWeight.w600)))
                          ],
                        ),
                        buildDivider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClaimCardDataItem(
                              title: S.of(context).priority,
                              data: pr?.claimsList[index]?.priority,
                            ),
                            ClaimCardDataItem(
                              title: S.of(context).unitName,
                              data: pr?.claimsList[index]?.unit?.name,
                            ),
                            ClaimCardDataItem(
                              title: S.of(context).claimCategory,
                              data: pr?.claimsList[index]?.category?.name,
                            ),
                            ClaimCardDataItem(
                              title: S.of(context).claimSubCategory,
                              data: pr?.claimsList[index]?.subCategory?.name,
                            ),
                            ClaimCardDataItem(
                              title: S.of(context).claimType,
                              data: pr?.claimsList[index]?.type?.name,
                            ),
                            ClaimCardDataItem(
                              title: S.of(context).createdAt,
                              data: pr?.claimsList[index]?.createdAt,
                            ),
                            ClaimCardDataItem(
                              isLast: true,
                              title: S.of(context).availableTime,
                              data: "${pr?.claimsList[index]?.availableDate.toString()} - ${pr?.claimsList[index]?.availableTime}"
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
              )
            : NoDataWidget(),
      ),
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
