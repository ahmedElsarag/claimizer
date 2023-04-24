import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../app_widgets/NoDataFoundGrid.dart';
import '../../../app_widgets/app_headline.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';

class SubcategoryGrid extends StatelessWidget {
  const SubcategoryGrid({Key key, this.onSelected}) : super(key: key);

  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
        builder: (ctx, pr, w) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppHeadline(title: S.of(context).selectClaimSubcategory),
                pr.subCategoryList.isNotEmpty
                    ? GridView.builder(
                        itemCount: pr.subCategoryList.length,
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
                        pr.selectedClaimSubCategoryIndex = index;
                        onSelected(pr.subCategoryList[index].id);
                        pr.selectedSubCategory = pr.subCategoryList[index].name;
                        pr.currentStep < 5 ? pr.currentStep += 1 : null;
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color:
                                      pr.selectedClaimSubCategoryIndex == index ? MColors.primary_color : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: MColors.dividerColor.withOpacity(.6), width: 2)),
                        child: Text(
                                pr.subCategoryList[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: pr.selectedClaimSubCategoryIndex == index ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : NoDataWidgetGrid(),
              ],
            ));
  }
}
