import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/home_screen/HomeProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_presenter.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:Cliamizer/ui/units_screen/widgets/unit_request_item_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/model_eventbus/EventBusUtils.dart';
import '../../../CommonUtils/model_eventbus/ReloadHomeEevet.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../unit_request_details_screen/UnitDetailsScreen.dart';

class UnitLinkRequest extends StatefulWidget {
  UnitLinkRequest({Key key, this.presenter, this.homeProvider, this.provider}) : super(key: key);
  final UnitPresenter presenter;
  final HomeProvider homeProvider;
  UnitProvider provider;

  @override
  State<UnitLinkRequest> createState() => _UnitLinkRequestState();
}

class _UnitLinkRequestState extends State<UnitLinkRequest> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.provider = context.read<UnitProvider>();
    EventBusUtils.getInstance().on<ReloadEvent>().listen((event) {
      if (event.isRefresh != null || event.isLangChanged != null) {
        widget.provider.currentPage = 1;
        Map<String, dynamic> linkRequestParams = Map();
        linkRequestParams['page'] = widget.provider.currentPage;
        linkRequestParams['per_page'] = 1000;
        linkRequestParams['search'] = widget.provider.searchController.text.toString();
        widget.presenter.getUnitRequestsApiCall(linkRequestParams);
      }
      setState(() {});
    });
    widget.provider.currentPage = 1;
    Map<String, dynamic> linkRequestParams = Map();
    linkRequestParams['page'] = widget.provider.currentPage;
    linkRequestParams['per_page'] = 1000;
    linkRequestParams['search'] = widget.provider.searchController.text.toString();
    widget.presenter.getUnitRequestsApiCall(linkRequestParams);
    // _scrollController.addListener(() {
    //   if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
    //     if (widget.provider.lastPage != widget.provider.currentPage && !widget.provider.isLoading) {
    //       widget.provider.isLoading = !widget.provider.isLoading;
    //       widget.provider.setCurrentPage();
    //       Map<String, dynamic> params = Map();
    //       params['page'] = widget.provider.currentPage;
    //       params['per_page'] = 1000;
    //       params['search'] = widget.provider.searchController.text.toString();
    //       widget.presenter.getUnitRequestsApiCall(params);
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
      _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeInOut);
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
      builder: (context, pr, child) => pr.unitsRequestList.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () async {
                pr.currentPage = 1;
                Map<String, dynamic> linkRequestParams = Map();
                linkRequestParams['page'] = widget.provider.currentPage;
                linkRequestParams['search'] = widget.provider.searchController.text.toString();
                widget.presenter.getUnitRequestsApiCall(linkRequestParams);
                pr.unitLinkSearchController.clear();
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: pr.unitsRequestList.length,
                itemBuilder: (context, index) {
                  if (index == pr.unitsRequestList.length - 1 && pr.isLoading)
                    return Center(child: Lottie.asset('assets/images/loadingLottie.json', height: 8.h));
                  else
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => UnitRequestDetailsScreen(
                                id: pr.unitsRequestList[index].id,
                                unitRequestDataBean: pr.unitsRequestList[index],
                              ),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
                        margin: index == 0 ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 2.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      pr.unitsRequestList[index].unitName ?? "",
                                      style: TextStyle(color: MColors.text_dark, fontWeight: FontWeight.bold),
                                    ),
                                    AutoSizeText(
                                      S.of(context).unitRequestCode + "\n" + pr.unitsRequestList[index].refCode,
                                      style: TextStyle(fontWeight: FontWeight.w500, color: MColors.subText_color),
                                    ),
                                  ],
                                ),
                                Card(
                                  color: widget.presenter
                                      .getUnitStatusColorFromString(pr?.unitsRequestList[index]?.status?.toLowerCase()),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                    child: AutoSizeText(
                                      pr?.unitsRequestList[index]?.status ?? '',
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            buildDivider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UnitRequestDataItem(
                                  title: S.of(context).unitName,
                                  data: pr.unitsRequestList[index].unitName,
                                  isLast: true,
                                ),
                                Gaps.vGap8,
                                UnitRequestDataItem(
                                  title: S.of(context).buildingName,
                                  data: pr.unitsRequestList[index].buildingName,
                                  isLast: true,
                                ),
                                Gaps.vGap8,
                                UnitRequestDataItem(
                                  title: S.of(context).unitType,
                                  data: pr.unitsRequestList[index].unitType,
                                  isLast: true,
                                ),
                                Gaps.vGap8,
                                UnitRequestDataItem(
                                  title: S.of(context).company,
                                  data: pr.unitsRequestList[index].company,
                                  isLast: true,
                                ),
                                Gaps.vGap8,
                                UnitRequestDataItem(
                                  title: S.of(context).contractNo,
                                  data: pr.unitsRequestList[index].contractNumber,
                                  isLast: true,
                                ),
                                Gaps.vGap8,
                                UnitRequestDataItem(
                                  title: S.of(context).startAt,
                                  data: pr.unitsRequestList[index].startAt,
                                  isLast: true,
                                ),
                                Gaps.vGap8,
                                UnitRequestDataItem(
                                  title: S.of(context).endAt,
                                  data: pr.unitsRequestList[index].endAt,
                                  isLast: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                },
              ),
            )
          : NoDataWidget(onRefresh: () async {
              pr.currentPage = 1;
              Map<String, dynamic> linkRequestParams = Map();
              linkRequestParams['page'] = widget.provider.currentPage;
              linkRequestParams['search'] = widget.provider.searchController.text.toString();
              widget.presenter.getUnitRequestsApiCall(linkRequestParams);
            }),
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
