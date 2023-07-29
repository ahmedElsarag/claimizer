import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:Cliamizer/ui/units_screen/widgets/complete_new_unit.dart';
import 'package:Cliamizer/ui/units_screen/widgets/existing_unit_list.dart';
import 'package:Cliamizer/ui/units_screen/widgets/search_qr_code_view.dart';
import 'package:Cliamizer/ui/units_screen/widgets/unit_link_request.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/image_utils.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import '../home_screen/HomeProvider.dart';
import 'units_presenter.dart';

class UnitsScreen extends StatefulWidget {
  static const String TAG = "/UnitsScreen";

  const UnitsScreen({Key key}) : super(key: key);

  @override
  State<UnitsScreen> createState() => UnitsScreenState();
}

class UnitsScreenState extends BaseState<UnitsScreen, UnitPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  UnitProvider provider;
  HomeProvider homeProvider;

  @override
  void initState() {
    provider = context.read<UnitProvider>();
    homeProvider = context.read<HomeProvider>();
    // EventBusUtils.getInstance().on<ReloadEvent>().listen((event) {
    //   if (event.isRefresh != null || event.isLangChanged != null) {
    //     Map<String, dynamic> linkRequestParams = Map();
    //     linkRequestParams['page'] = provider.currentPage;
    //     linkRequestParams['search'] = provider.searchController.text.toString();
    //     mPresenter.getUnitRequestsApiCall(linkRequestParams);
    //   }
    //   setState(() {});
    // });
    // Map<String, dynamic> exitingParams = Map();
    // exitingParams['page'] = provider.currentPage;
    // exitingParams['search'] = provider.searchController.text.toString();
    // mPresenter.getExistingUnitsApiCall(exitingParams);
    // Map<String, dynamic> linkRequestParams = Map();
    // linkRequestParams['page'] = provider.currentPage;
    // linkRequestParams['search'] = provider.searchController.text.toString();
    // mPresenter.getUnitRequestsApiCall(linkRequestParams);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> cardTitles = [
      S.current.newLinkRequest,
      S.current.existingUnit,
      S.current.unitLinkRequest,
    ];
    List<String> cardImages = [
      'new_unit_link',
      'existing_unit',
      'unit_link_request',
    ];
    super.build(context);
    return Scaffold(
      backgroundColor: MColors.page_background,
      body: Consumer<UnitProvider>(
        builder: (context, pr, child) => Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 60, 16, 0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 1.w,
                          height: 5.w,
                          margin: EdgeInsetsDirectional.only(end: 2.w),
                          decoration:
                              BoxDecoration(color: MColors.primary_color, borderRadius: BorderRadius.circular(4)),
                        ),
                        Text(S.of(context).unitsProperty, style: MTextStyles.textMain18),
                      ],
                    ),
                    Gaps.vGap16,
                    Consumer<UnitProvider>(
                      builder: (context, pr, child) => Container(
                        height: 14.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cardTitles.length,
                          itemBuilder: (context, pageIndex) {
                            return GestureDetector(
                              onTap: () {
                                pr.selectedIndex = pageIndex;
                              },
                              child: Card(
                                elevation: 0.5,
                                color: pr.selectedIndex == pageIndex ? MColors.primary_color : Colors.white,
                                child: SizedBox(
                                  width: 25.w,
                                  height: 102,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        ImageUtils.getSVGPath(cardImages[pageIndex]),
                                        color: pr.selectedIndex == pageIndex ? Colors.white : MColors.primary_color,
                                      ),
                                      SizedBox(
                                        width: pr.selectedIndex == pageIndex ? 80 : 90,
                                        child: AutoSizeText(
                                          cardTitles[pageIndex],
                                          style: TextStyle(
                                            color:
                                                pr.selectedIndex == pageIndex ? Colors.white : MColors.light_text_color,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gaps.vGap12,
              Visibility(
                visible: pr.selectedIndex != 0,
                child: Container(
                  decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // width: 237,
                          height: 10.w,
                          child: TextFormField(
                            style: MTextStyles.textDark14,
                            controller: pr.selectedIndex == 1 ? pr.searchController : pr.unitLinkSearchController,
                            decoration: InputDecoration(
                              hintText: S.current.search,
                              hintStyle: MTextStyles.textGray14,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: Color(0xffF7F7F7),
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  CupertinoIcons.search,
                                  color: MColors.primary_light_color,
                                ),
                                onTap: () {
                                  if (pr.selectedIndex == 1) {
                                    Map<String, dynamic> exitingParams = Map();
                                    exitingParams['search'] = provider.searchController.text.toString();
                                    mPresenter.getExistingUnitsApiCall(exitingParams);
                                  } else if (pr.selectedIndex == 2) {
                                    Map<String, dynamic> params = Map();
                                    params['search'] = pr.unitLinkSearchController.text.toString();
                                    mPresenter.getUnitRequestsApiCall(params);
                                  }
                                },
                              ),
                              suffixIcon: GestureDetector(
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: MColors.primary_light_color,
                                ),
                                onTap: () {
                                  if (pr.selectedIndex == 1) {
                                    Map<String, dynamic> exitingParams = Map();
                                    exitingParams['search'] = provider.searchController.text.toString();
                                    mPresenter.getExistingUnitsApiCall(exitingParams);
                                    pr.searchController.clear();
                                  } else if (pr.selectedIndex == 2) {
                                    pr.unitLinkSearchController.clear();

                                    Map<String, dynamic> linkRequestParams = Map();
                                    linkRequestParams['search'] = provider.unitLinkSearchController.text.toString();
                                    mPresenter.getUnitRequestsApiCall(linkRequestParams);
                                  }
                                },
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              if (pr.selectedIndex == 1) {
                                Map<String, dynamic> exitingParams = Map();
                                exitingParams['search'] = provider.searchController.text.toString();
                                mPresenter.getExistingUnitsApiCall(exitingParams);
                              } else if (pr.selectedIndex == 2) {
                                Map<String, dynamic> params = Map();
                                params['search'] = pr.unitLinkSearchController.text.toString();
                                mPresenter.getUnitRequestsApiCall(params);
                              }
                            },
                            onChanged: (value) {
                              pr.searchValue = value;
                            },
                          ),
                        ),
                      ),
                      // SizedBox(width: 17.0),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Container(
                      //     width: 36,
                      //     height: 36,
                      //     padding: EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(8),
                      //         color: MColors.whiteE,
                      //         boxShadow: [
                      //           BoxShadow(
                      //               color: MColors.coolGrey.withOpacity(0.2),
                      //               spreadRadius: 1,
                      //               blurRadius: 5,
                      //               offset: Offset(1, 4))
                      //         ]),
                      //     child: SvgPicture.asset(ImageUtils.getSVGPath("filter")),
                      //   ),
                      // ),
                      // Gaps.hGap8,
                      // InkWell(
                      //   onTap: () {},
                      //   child: Container(
                      //     width: 36,
                      //     height: 36,
                      //     padding: EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(8),
                      //       color: Color(0xffF7F7F7),
                      //     ),
                      //     child: SvgPicture.asset(ImageUtils.getSVGPath("export")),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  children: [
                    pr.selectedIndex == 0
                        ? !pr.isQrCodeValid
                            ? SearchAboutUnitByQR(
                                provider: provider,
                                presenter: mPresenter,
                              )
                            : CompleteNewUnit(
                                provider: provider,
                                presenter: mPresenter,
                              )
                        : pr.selectedIndex == 1
                            ? ExistingUnitList(
                                presenter: mPresenter,
                                provider: pr,
                              )
                            : UnitLinkRequest(
                                presenter: mPresenter,
                                homeProvider: homeProvider,
                                provider: pr,
                              ),
                  ],
                ),
              )
            ],
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

  @override
  createPresenter() {
    return UnitPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 237,
      height: 10.w,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: MTextStyles.textGray14,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: MColors.primary_light_color,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: Color(0xffF7F7F7),
        ),
      ),
    );
  }
}
