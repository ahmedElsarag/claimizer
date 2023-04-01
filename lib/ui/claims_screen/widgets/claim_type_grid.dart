import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_widgets/app_headline.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';

class ClaimTypeGrid extends StatelessWidget {
  const ClaimTypeGrid({Key key, this.onSelected}) : super(key: key);

  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
        builder: (ctx, pr, w) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppHeadline(title: S.of(context).selectClaimType),
                GridView.builder(
                  itemCount: pr.claimTypeList.length,
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
                        pr.selectedClaimTypeIndex = index;
                        onSelected(pr.claimTypeList[index].id);
                        pr.currentStep < 6 ? pr.currentStep += 1 : null;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: pr.selectedClaimTypeIndex == index ? MColors.primary_color : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: MColors.dividerColor.withOpacity(.6), width: 2)),
                        child: Center(
                          child: Text(
                            pr.claimTypeList[index].name,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: pr.selectedClaimTypeIndex == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ));
  }
}
