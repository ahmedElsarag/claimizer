import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsScreen.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsPresenter.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/claim_card_data_item.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../CommonUtils/utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class AllClaims extends StatelessWidget {
  const AllClaims({Key key, this.presenter}) : super(key: key);
  final ClaimsPresenter presenter;

  @override
  Widget build(BuildContext context) {
    String formatDate(String date){
      String dateTimeString = date;
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDateString = DateFormat("dd-MM-yyyy | hh:mm a").format(dateTime.toLocal());
      return formattedDateString;
    }
    return Consumer<ClaimsWithFilterProvider>(
        builder: (ctx, pr, w) => MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: pr.claimsList.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        pr.searchController.text = "";
                        await presenter.getAllClaimsApiCall();
                      },
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: pr.claimsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => ClaimsDetailsScreen(
                                      id: pr.claimsList[index].id,
                                      claimsDataBean: pr.claimsList[index],
                                    ),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                              margin: EdgeInsets.only(
                                  top: index == 0 ? 20 : 0, bottom: index == pr.claimsList.length - 1 ? 20 : 0),
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
                                          AutoSizeText(
                                            pr?.claimsList[index]?.unit?.building ?? S.current.na,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.black, fontWeight: FontWeight.w600
                                            ),textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            S.of(context).requestCode + "\n ${pr?.claimsList[index]?.referenceId}",
                                            style: MTextStyles.textSubtitle,
                                          ),
                                        ],
                                      ),
                                      Card(
                                        color: presenter.getClaimStatusColorFromString(
                                            pr?.claimsList[index]?.status?.toLowerCase()),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                          child: FittedBox(
                                            child: Text(
                                              pr?.claimsList[index]?.status ?? '',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.white, fontWeight: FontWeight.w600
                                              ),textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  buildDivider(),
                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        data:Utils.formatDate(pr?.claimsList[index]?.createdAt),
                                      ),
                                      ClaimCardDataItem(
                                          isLast: true,
                                          title: S.of(context).availableTime,
                                          data:
                                              "${pr?.claimsList[index]?.availableDate.toString()}\n${pr?.claimsList[index]?.availableTime}"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                      ),
                    )
                  : NoDataWidget(
                      onRefresh: () async {
                        await presenter.getAllClaimsApiCall();
                      },
                    ),
            ));
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
