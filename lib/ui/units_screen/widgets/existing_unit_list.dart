import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/units_screen/units_presenter.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../CommonUtils/utils.dart';
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
    widget.provider.currentPage = 1;
    Map<String, dynamic> params = Map();
    params['page'] = widget.provider.currentPage;
    params['search'] = widget.provider.searchController.text.toString();
    widget.presenter.getExistingUnitsApiCall(params);
    // _scrollController.addListener(() {
    //   if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
    //     if (widget.provider.lastPage != widget.provider.currentPage && !widget.provider.isLoading) {
    //       widget.provider.isLoading = !widget.provider.isLoading;
    //       widget.provider.setCurrentPage();
    //       Map<String, dynamic> params = Map();
    //       params['page'] = widget.provider.currentPage;
    //       params['search'] = widget.provider.searchController.text.toString();
    //       widget.presenter.getExistingUnitsApiCall(params);
    //       print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${widget.provider.currentPage}");
    //       print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ search: ${widget.provider.searchController.text}");
    //     }
    //   }
    // });

    super.initState();
  }
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _scrollController.animateTo(0,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
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
                  widget.provider.currentPage = 1;
                  Map<String, dynamic> params = Map();
                  params['page'] = widget.provider.currentPage;
                  params['search'] = widget.provider.searchController.text.toString();
                  await widget.presenter.getExistingUnitsApiCall(params);
                },
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: pr.unitsList.length,
                  itemBuilder: (context, index) {
                    if (index == pr.unitsList.length -1)
                      return Container(
                        margin: const EdgeInsets.only(top: 12.0,bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Visibility(
                              visible: pr.currentPage != 1,
                              child: InkWell(
                                  onTap: () {
                                    pr.currentPage -= 1;
                                    Map<String, dynamic> params = Map();
                                    params['page'] = pr.currentPage;
                                    params['search'] = pr.searchController.text.toString();
                                    widget.presenter.getExistingUnitsApiCall(params);
                                    _scrollListener();
                                  },
                                  child: SvgPicture.asset(
                                    ImageUtils.getSVGPath("back_icon"),
                                  )),
                            ),
                            Text(pr.currentPage.toString()),
                            Visibility(
                              visible: pr.currentPage != pr.lastPage,
                              child: InkWell(
                                  onTap: () {
                                    pr.currentPage += 1;
                                    Map<String, dynamic> params = Map();
                                    params['page'] = pr.currentPage;
                                    params['search'] = pr.searchController.text.toString();
                                    widget.presenter.getExistingUnitsApiCall(params);
                                    _scrollListener();
                                  },
                                  child: RotatedBox(
                                    quarterTurns: 2,
                                    child: SvgPicture.asset(
                                      ImageUtils.getSVGPath("back_icon"),
                                    ),
                                  )),
                            )
                            // Center(child: Lottie.asset('assets/images/loadingLottie.json', height: 8.h)),
                          ],
                        ),
                      );
                    else
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).unitName + " :    ",
                                      style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                    ),
                                    SizedBox(
                                      width: Utils.sWidth(40, context),
                                      child: AutoSizeText(
                                        pr.unitsList[index].name ?? "",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                    )
                                  ],
                                ),
                                Gaps.vGap8,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).buildingName + " :    ",
                                      style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                    ),
                                    SizedBox(
                                      width: Utils.sWidth(40, context),
                                      child: AutoSizeText(
                                        pr.unitsList[index].building ?? "",
                                        maxLines: 2,
                                        style: MTextStyles.textSubtitle,
                                      ),
                                    )
                                  ],
                                ),
                                Gaps.vGap8,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).unitType + " :    ",
                                      style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                    ),
                                    SizedBox(
                                      width: Utils.sWidth(40, context),
                                      child: AutoSizeText(
                                        pr.unitsList[index].type ?? "",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                    )
                                  ],
                                ),
                                Gaps.vGap8,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).company + " :    ",
                                      style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                    ),
                                    SizedBox(
                                      width: Utils.sWidth(40, context),
                                      child: AutoSizeText(
                                        pr.unitsList[index].company ?? "",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                    )
                                  ],
                                ),
                                Gaps.vGap8,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).contractNo + " :    ",
                                      style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                    ),
                                    SizedBox(
                                      width: Utils.sWidth(40, context),
                                      child: AutoSizeText(
                                        pr.unitsList[index].id.toString() ?? "",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                    )
                                  ],
                                ),
                                Gaps.vGap8,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).startAt + " :    ",
                                      style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                    ),
                                    SizedBox(
                                      width: Utils.sWidth(40, context),
                                      child: AutoSizeText(
                                        pr.unitsList[index].startAt ?? "",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                    )
                                  ],
                                ),
                                Gaps.vGap8,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).endAt + " :    ",
                                      style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                    ),
                                    SizedBox(
                                      width: Utils.sWidth(40, context),
                                      child: AutoSizeText(
                                        pr.unitsList[index].endAt ?? "",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                    )
                                  ],
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
                  widget.provider.currentPage = 1;
                  Map<String, dynamic> params = Map();
                  params['page'] = widget.provider.currentPage;
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
