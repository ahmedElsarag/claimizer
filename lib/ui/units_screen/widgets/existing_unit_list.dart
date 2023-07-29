import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/units_screen/units_presenter.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:Cliamizer/ui/units_screen/widgets/unit_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class ExistingUnitList extends StatefulWidget {
  ExistingUnitList({Key key, this.presenter, this.provider}) : super(key: key);
  final UnitPresenter presenter;
  UnitProvider provider;

  @override
  State<ExistingUnitList> createState() => _ExistingUnitListState();
}

class _ExistingUnitListState extends State<ExistingUnitList> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.provider = context.read<UnitProvider>();
    Map<String, dynamic> params = Map();
    params['search'] = widget.provider.searchController.text.toString();
    widget.presenter.getExistingUnitsApiCall(params);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) {
        return pr.unitsList.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  pr.searchController.clear();
                  Map<String, dynamic> params = Map();
                  params['search'] = widget.provider.searchController.text.toString();
                  await widget.presenter.getExistingUnitsApiCall(params);
                },
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: pr.unitsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
                      margin: index == 0 ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 2.w),
                      child: Column(
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                      pr.unitsList[index].name ?? "",
                                      style: MTextStyles.textBoldDark16,
                                    ),
                                    Text(
                                      S.of(context).unitCode + pr.unitsList[index].code,
                                      style: MTextStyles.textSubtitle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            buildDivider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UnitCardItem(
                                  title: S.of(context).unitName ,
                                  data: pr.unitsList[index].name ?? "",
                                ),
                                Gaps.vGap8,
                                UnitCardItem(
                                  title: S.of(context).buildingName ,
                                  data: pr.unitsList[index].building ?? "",
                                ),
                                Gaps.vGap8,
                                UnitCardItem(
                                  title: S.of(context).unitType ,
                                  data: pr.unitsList[index].type ?? "",
                                ),
                                Gaps.vGap8,
                                UnitCardItem(
                                  title: S.of(context).company ,
                                  data: pr.unitsList[index].company ?? "",
                                ),
                                Gaps.vGap8,
                                UnitCardItem(
                                  title: S.of(context).contractNo ,
                                  data: pr.unitsList[index].id.toString() ?? "",
                                ),
                                Gaps.vGap8,
                                UnitCardItem(
                                  title: S.of(context).startAt ,
                                  data: pr.unitsList[index].startAt ?? "",
                                ),
                                Gaps.vGap8,
                                UnitCardItem(
                                  title: S.of(context).endAt ,
                                  data: pr.unitsList[index].endAt ?? "",
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                  },
                ),
              )
            : NoDataWidget(
                onRefresh: () async {
                  Map<String, dynamic> params = Map();
                  params['search'] = widget.provider.searchController.text.toString();
                  await widget.presenter.getExistingUnitsApiCall(params);
                },
              );
      },
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
