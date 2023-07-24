import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/more_screen/MoreScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/image_utils.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../claims_screen/claims_screen.dart';
import '../home_screen/HomeScreen.dart';
import '../main_screens/MainPresenter.dart';
import '../units_screen/units_screen.dart';
import 'MainProvider.dart';

class MainScreen extends StatefulWidget {
  final bool langChanged;

  MainScreen({this.langChanged = false});

  static const String TAG = "/MainScreen";

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends BaseState<MainScreen, MainPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  DateTime currentBackPressTime;
  MainProvider pr;

  @override
  void initState() {
    pr = context.read<MainProvider>();
    pr.tabController = TabController(vsync: this, length: 4,initialIndex: 0);
    pr.tabController.addListener(_handleTabSelection);
  super.initState();
  }

  void _handleTabSelection() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController();
    super.build(context);
    return Consumer<MainProvider>(
      builder: (context, mainProvider, _) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: pr.tabController,
              children: [
                HomeScreen(),
                ClaimsScreen(isFilteredFromHome: false),
                UnitsScreen(),
                MoreScreen(),
              ],
            ),
            bottomNavigationBar: Container(
              height: 10.h,
              padding: EdgeInsets.only(top: 1.h, left: 1.w, right: 1.w,bottom: 1.h),
              color: MColors.white,
              child: TabBar(
                controller: pr.tabController,
                labelStyle:  TextStyle(fontSize: 10.sp),
                isScrollable: false,
                unselectedLabelColor: MColors.subText_color,
                automaticIndicatorColorAdjustment: true,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  FittedBox(
                    child: Tab(
                      icon: SvgPicture.asset(
                        ImageUtils.getSVGPath('home'),
                        color: pr.tabController.index == 0 ? MColors.primary_color : MColors.tabsTextColor,
                      ),
                      text: S.of(context).home,
                    ),
                  ),
                  FittedBox(
                    child: Tab(
                      icon: SvgPicture.asset(
                        ImageUtils.getSVGPath('claims'),
                        color: pr.tabController.index == 1 ? MColors.primary_color : MColors.tabsTextColor,
                      ),
                      text: S.of(context).claims,
                    ),
                  ),
                  FittedBox(
                    child: Tab(
                      icon: SvgPicture.asset(
                        ImageUtils.getSVGPath('units'),
                        color: pr.tabController.index == 2 ? MColors.primary_color : MColors.tabsTextColor,
                      ),
                      text: S.of(context).units,
                    ),
                  ),
                  FittedBox(
                    child: Tab(
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        color: pr.tabController.index == 3 ? MColors.primary_color : MColors.tabsTextColor,
                      ),
                      text: S.of(context).more,
                    ),
                  ),
                ],
                // labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  MainPresenter createPresenter() {
    return MainPresenter();
  }

  @override
  bool get wantKeepAlive => false;
}
