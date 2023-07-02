import 'package:Cliamizer/ui/claims_screen/ClaimsPresenter.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/claims_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../app_widgets/NoDataFoundGrid.dart';
import '../../../app_widgets/app_headline.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';

class UnitsGrid extends StatelessWidget {
  const UnitsGrid({Key key, this.onSelected, this.presenter, this.id}) : super(key: key);
  final ClaimsPresenter presenter;
  final Function(int) onSelected;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsWithFilterProvider>(
      builder: (ctx, pr, w) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppHeadline(title: S.of(context).selectUnit),
          pr.unitsList.isNotEmpty
              ? GridView.builder(
                  itemCount: pr.unitsList.length,
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
                        pr.selectedUnitIndex = index;
                        pr.companyId = pr.unitsList[index].companyId;
                        onSelected(pr.unitsList[index].id);
                        pr.selectedUnit = pr.unitsList[index].name;
                        pr.currentStep < 3 ? pr.currentStep += 1 : null;
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: pr.selectedUnitIndex == index ? MColors.primary_color : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: MColors.dividerColor.withOpacity(.6), width: 2)),
                        child: Text(
                          pr.unitsList[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: pr.selectedUnitIndex == index ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : pr.dataLoaded
                  ? NoDataWidgetGrid(
                      onRefresh: () async {
                        presenter.getUnitsApiCall(id);
                      },
                    )
                  : ClaimsLoading(),
        ],
      ),
    );
  }
}
