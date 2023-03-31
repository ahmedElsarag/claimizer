import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsScreen.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class AllClaims extends StatelessWidget {
  const AllClaims({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (ctx, pr, w) => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 5/*pr.claimsList.length*/,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(builder:(context) => ClaimsDetailsScreen(id: index),));
              },
              child: Container(
                decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.only(top: index == 0 ? 20 : 0, bottom: index == pr.claimsList.length - 1 ? 20 : 0),
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
                              "Falcon Tower A5 - Owned",
                              style: MTextStyles.textBoldDark16,
                            ),
                            Text(
                              S.of(context).requestCode + " #123-45-567",
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
                            child: Text("Complete"/*pr?.claimsList[index]?.status ?? ''*/,
                                style: MTextStyles.textDark12
                                    .copyWith(color: MColors.blueButtonColor, fontWeight: FontWeight.w600)))
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
                              S.of(context).priority,
                              style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                            ),
                            Text(
                              "High",
                              style: MTextStyles.textSubtitle.copyWith(
                                color: MColors.primary_color
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).unitName,
                              style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                            ),
                            Text(
                              "omnis",
                              style: MTextStyles.textSubtitle,
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.claimCategory,
                              style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                            ),
                            Text(
                              "Falcon Tower A5 - Owned",
                              style: MTextStyles.textSubtitle,
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).claimSubCategory,
                              style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                            ),
                            Text(
                              "Falcon Tower A5 - Owned",
                              style: MTextStyles.textSubtitle,
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).claimType,
                              style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                            ),
                            Text(
                              "qui",
                              style: MTextStyles.textSubtitle,
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).createdAt,
                              style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                            ),
                            Text(
                              "2023-03-03",
                              style: MTextStyles.textSubtitle,
                            ),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).availableTime,
                              style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                            ),
                            Text(
                              "From 10 AM to 12 PM - 23/2/2023 ",
                              style: MTextStyles.textSubtitle,
                            ),
                          ],
                        ),
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
