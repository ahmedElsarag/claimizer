import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/ClaimsWithFilter/widgets/all_claims.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/claimizer_app_bar.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import 'ClaimsWithFitlerPresenter.dart';

class ClaimsWithFilterScreen extends StatefulWidget {
  static const String TAG = "/ClaimsScreen";

  const ClaimsWithFilterScreen({Key key, this.isFilteredFromHome}) : super(key: key);
  final bool isFilteredFromHome;

  @override
  State<ClaimsWithFilterScreen> createState() => ClaimsWithFilterScreenState();
}

class ClaimsWithFilterScreenState extends BaseState<ClaimsWithFilterScreen, ClaimsWithFilterPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  ClaimsWithFilterProvider provider;

  final searchController = TextEditingController();

  @override
  void initState() {
    provider = context.read<ClaimsWithFilterProvider>();
    mPresenter.getFilteredClaimsWithStatusApiCall(provider.status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: MColors.page_background,
      body: Consumer<ClaimsWithFilterProvider>(
        builder: (context, pr, child) => Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 60, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClaimizerAppBar(title: pr.status +" "+S.current.claims),
              Gaps.vGap16,
              Visibility(
                visible: pr.selectedIndex != 0,
                child: Container(
                  decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // width: 237,
                          height: 10.w,
                          child: TextFormField(
                            style: MTextStyles.textDark14,
                            controller: pr.searchController,
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
                                  Map<String, dynamic> parms = Map();
                                  parms['property'] = pr.searchController.text.toString();
                                  mPresenter.getFilteredClaimsApiCall(parms);
                                },
                              ),
                              suffixIcon: GestureDetector(
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: MColors.primary_light_color,
                                ),
                                onTap: () {
                                  pr.searchController.clear();
                                  mPresenter.getFilteredClaimsWithStatusApiCall(provider.status);
                                },
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              Map<String, dynamic> parms = Map();
                              parms['property'] = pr.searchController.text.toString();
                              parms['status'] = pr.status;
                              mPresenter.getFilteredClaimsApiCall(parms);
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
                child: AllClaimsWithFilter(
                        presenter: mPresenter,
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
    return ClaimsWithFilterPresenter();
  }

  @override
  bool get wantKeepAlive => false;
}
