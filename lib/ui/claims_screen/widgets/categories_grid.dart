import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../app_widgets/NoDataFoundGrid.dart';
import '../../../app_widgets/app_headline.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../ClaimsPresenter.dart';
import 'claims_loading.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({Key key, this.onSelected, this.presenter, this.id}) : super(key: key);
  final ClaimsPresenter presenter;
  final Function(int) onSelected;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
        builder: (ctx, pr, w) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppHeadline(title: S.of(context).selectClaimCategory),
                pr.categoriesList.isNotEmpty
                    ? GridView.builder(
                        itemCount: pr.categoriesList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          childAspectRatio: 1.0,
                          maxCrossAxisExtent: 40.w,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              pr.selectedClaimCategoryIndex = index;
                              onSelected(index);
                              pr.selectedCategory = pr.categoriesList[index].name;
                              pr.currentStep < 4 ? pr.currentStep += 1 : null;
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: pr.selectedClaimCategoryIndex == index ? MColors.primary_color : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: MColors.dividerColor.withOpacity(.6), width: 2)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (pr.categoriesList[index]?.icon != null)
                                    SvgPicture.network(
                                      pr.categoriesList[index]?.icon ?? '',
                                      width: 40,
                                    ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    pr.categoriesList[index]?.name ?? "",
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: pr.selectedClaimCategoryIndex == index ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : pr.dataLoaded
                        ? NoDataWidgetGrid(
                            onRefresh: () async {
                              presenter.getCategoryApiCall(id);
                            },
                          )
                        : ClaimsLoading(),
              ],
            ));
  }
}
