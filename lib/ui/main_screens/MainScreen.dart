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
  TabController _tabController;

  @override
  void initState() {
    pr = context.read<MainProvider>();
    pr.currentSelect = 0;
    _tabController = TabController(vsync: this, length: 4);
    if (mounted)
      _tabController.addListener(() {
        pr.currentSelect = _tabController.index;
      });
    super.initState();
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
              controller: _tabController,
              children: [
                HomeScreen(),
                ClaimsScreen(),
                UnitsScreen(),
                MoreScreen(),
              ],
            ),
            bottomNavigationBar: Container(
              height: 9.h,
              padding: EdgeInsets.only(top: 1.h, left: 1.w, right: 1.w,bottom: 1.h),
              color: MColors.white,
              child: TabBar(
                controller: _tabController,
                labelStyle: TextStyle(fontSize: 8.sp),
                isScrollable: false,
                unselectedLabelColor: MColors.subText_color,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    icon: SvgPicture.asset(
                      ImageUtils.getSVGPath('home'),
                      color: mainProvider.currentSelect == 0 ? MColors.primary_color : MColors.tabsTextColor,
                    ),
                    text: S.of(context).home,
                  ),
                  Tab(
                    icon: SvgPicture.asset(
                      ImageUtils.getSVGPath('claims'),
                      color: mainProvider.currentSelect == 1 ? MColors.primary_color : MColors.tabsTextColor,
                    ),
                    text: S.of(context).claims,
                  ),
                  Tab(
                    icon: SvgPicture.asset(
                      ImageUtils.getSVGPath('units'),
                      color: mainProvider.currentSelect == 2 ? MColors.primary_color : MColors.tabsTextColor,
                    ),
                    text: S.of(context).units,
                  ),
                  Tab(
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: mainProvider.currentSelect == 3 ? MColors.primary_color : MColors.tabsTextColor,
                    ),
                    text: S.of(context).more,
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
