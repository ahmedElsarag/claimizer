import 'package:Cliamizer/app_widgets/NoDataFound.dart';
import 'package:Cliamizer/ui/ClaimsWithFilter/ClaimsWithFitlerPresenter.dart';
import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsScreen.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/claim_card_data_item.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../ClaimsWithFitlerProvider.dart';

class AllClaimsWithFilter extends StatefulWidget {
  AllClaimsWithFilter({Key key, this.presenter, this.provider}) : super(key: key);
  final ClaimsWithFilterPresenter presenter;
  ClaimsWithFilterProvider provider;

  @override
  State<AllClaimsWithFilter> createState() => _AllClaimsWithFilterState();
}

class _AllClaimsWithFilterState extends State<AllClaimsWithFilter> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.provider = context.read<ClaimsWithFilterProvider>();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        if (widget.provider.lastPage != widget.provider.currentPage && !widget.provider.isLoading) {
          widget.provider.isLoading = !widget.provider.isLoading;
          widget.provider.setCurrentPage();
          Map<String, dynamic> params = Map();
          params['page'] = widget.provider.currentPage;
          params['per_page'] = 1000;
          params['search'] = widget.provider.searchController.text.toString();
          params['status'] = widget.provider.status;
          widget.presenter.getFilteredClaimsWithStatusApiCall(params);
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${widget.provider.currentPage}");
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ search: ${widget.provider.searchController.text}");
        }
      }
    });
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
    String formatDate(String date) {
      String dateTimeString = date;
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDateString = DateFormat("dd-MM-yyyy | hh:mm a").format(dateTime.toLocal());
      return formattedDateString;
    }

    return Consumer<ClaimsWithFilterProvider>(
        builder: (ctx, pr, w) => MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: pr.claimsList.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        pr.searchController.text = "";
                        Map<String, dynamic> params = Map();
                        params['per_page'] = 1000;
                        params['page'] = 1;
                        params['search'] = widget.provider.searchController.text.toString();
                        params['status'] = widget.provider.status;
                        await widget.presenter.getFilteredClaimsWithStatusApiCall(params);
                        // await widget.presenter.getFilteredClaimsWithStatusApiCall(pr.status);
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: pr.claimsList.length,
                        itemBuilder: (context, index) {
                          if (index == pr.claimsList.length - 1 && pr.isLoading)
                            return Center(child: Lottie.asset('assets/images/loadingLottie.json', height: 8.h));
                          else
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => ClaimsDetailsScreen(
                                        id: pr.claimsList[index].id,
                                        claimsDataBean: pr.claimsList[index],
                                      ),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                                margin: EdgeInsets.only(
                                    top: index == 0 ? 20 : 0, bottom: index == pr.claimsList.length - 1 ? 20 : 0),
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
                                            FittedBox(
                                              child: SizedBox(
                                                width: Utils.sWidth(40, context),
                                                child: AutoSizeText(
                                                  pr?.claimsList[index]?.unit?.building ?? S.current.na,
                                                  // maxLines: 2,
                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Utils.sWidth(40, context),
                                              child: AutoSizeText(
                                                S.of(context).requestCode + "\n ${pr?.claimsList[index]?.referenceId}",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500, color: MColors.subText_color),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Card(
                                          color: widget.presenter.getClaimStatusColorFromString(
                                              pr?.claimsList[index]?.status?.toLowerCase()),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(32),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                            child: FittedBox(
                                              child: Text(
                                                pr?.claimsList[index]?.status ?? '',
                                                maxLines: 1,
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    buildDivider(),
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClaimCardDataItem(
                                          title: S.of(context).priority,
                                          data: pr?.claimsList[index]?.priority,
                                        ),
                                        ClaimCardDataItem(
                                          title: S.of(context).unitName,
                                          data: pr?.claimsList[index]?.unit?.name,
                                        ),
                                        ClaimCardDataItem(
                                          title: S.of(context).claimCategory,
                                          data: pr?.claimsList[index]?.category?.name,
                                        ),
                                        ClaimCardDataItem(
                                          title: S.of(context).claimSubCategory,
                                          data: pr?.claimsList[index]?.subCategory?.name,
                                        ),
                                        ClaimCardDataItem(
                                          title: S.of(context).claimType,
                                          data: pr?.claimsList[index]?.type?.name,
                                        ),
                                        ClaimCardDataItem(
                                          title: S.of(context).createdAt,
                                          data: Utils.formatDate(pr?.claimsList[index]?.createdAt),
                                        ),
                                        ClaimCardDataItem(
                                            isLast: true,
                                            title: S.of(context).availableTime,
                                            data:
                                                "${pr?.claimsList[index]?.availableDate.toString()}\n${pr?.claimsList[index]?.availableTime}"),
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
                    )
                  : NoDataWidget(
                      onRefresh: () async {
                        Map<String, dynamic> params = Map();
                        params['per_page'] = 1000;
                        params['page'] = 1;
                        params['search'] = widget.provider.searchController.text.toString();
                        params['status'] = widget.provider.status;
                        await widget.presenter.getFilteredClaimsWithStatusApiCall(params);
                        // await widget.presenter.getFilteredClaimsWithStatusApiCall(pr.status);
                      },
                    ),
            ));
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
