import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
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
          itemCount: pr.claimsList.length,
          itemBuilder: (context, index) {
            return Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).unitName,
                            style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            "2023-10-14",
                            style: MTextStyles.textSubtitle,
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
                            "Falacon unit",
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).clientId,
                            style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            "345567890",
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
                            style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            "2023-10-14",
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
                            style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                          ),
                          Text(
                            "2023-10-14",
                            style: MTextStyles.textSubtitle,
                          ),
                        ],
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
