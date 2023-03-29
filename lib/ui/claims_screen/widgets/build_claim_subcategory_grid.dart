import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_widgets/app_headline.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../ClaimsProvider.dart';

class BuildClaimSubCategoryGrid extends StatelessWidget {
  BuildClaimSubCategoryGrid({Key key, this.itemsList, this.selectedSubCategory}) : super(key: key);
  final List<String> itemsList;
  String selectedSubCategory;
  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (context, pr, child) =>  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppHeadline(title: S
              .of(context)
              .selectClaimSubcategory),
          GridView.builder(
            itemCount: itemsList.length,
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
                  selectedSubCategory = itemsList[index];
                  pr.currentStep < 5 ? pr.currentStep += 1 : null;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: pr.selectedClaimSubCategoryIndex == index
                          ? MColors.primary_color
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: MColors.dividerColor.withOpacity(.6),
                          width: 2)),
                  child: Center(
                    child: Text(
                      itemsList[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: pr.selectedClaimSubCategoryIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
