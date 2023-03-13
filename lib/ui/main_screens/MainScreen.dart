import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/qr_screen/qr_screen.dart';

import '../../CommonUtils/image_utils.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../home_screen/HomeScreen.dart';
import '../main_screens/MainPresenter.dart';
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
  Future<bool> onWillPop() {
    if (pr.tabController.index != 0) {
      mPresenter.changeTabScreen(0);
      pr.currentSelect = 0;
      pr.tabController =
          TabController(vsync: this, length: pr.pages.length);
      pr.tabController.addListener(() {
        mPresenter.changeTabScreen(pr.tabController.index);
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void initState() {
    super.initState();

    pr = context.read();
    if (widget.langChanged) {
      mPresenter.changeTabScreen(2);
      pr.currentSelect = 2;
      pr.tabController = TabController(
          vsync: this, length: pr.pages.length, initialIndex: 2);
      pr.tabController.addListener(() {
        mPresenter.changeTabScreen(pr.tabController.index);
      });
    } else {
      pr.pages;
      pr.tabController =
          TabController(vsync: this, length: pr.pages.length);
      pr.tabController.addListener(() {
        mPresenter.changeTabScreen(pr.tabController.index);
      });
    }

    mPresenter.getLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController();
    super.build(context);
    return Consumer<MainProvider>(
        builder: (context, mainProvider, _) {
          return WillPopScope(
            onWillPop: () async {
              return onWillPop();
            },
            child: DefaultTabController(
              length: mainProvider.pages.length,
              child: Scaffold(
                body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: mainProvider.tabController,
                  children: [
                    HomeScreen(title: 'home',),
                    QrScreen(),
                    HomeScreen(title: 'third',),
                  ],
                ),
                bottomNavigationBar: Container(
                  height: 8.h,
                  padding: EdgeInsets.only(top: 1.h, left: 1.w, right: 1.w,bottom: 1.h),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,spreadRadius: 1,offset: Offset(0, 4)
                      )
                    ],
                    color: MColors.btn_color,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft:  Radius.circular(16))
                  ),
                  child: TabBar(
                    controller: mainProvider.tabController,
                    tabs: [
                      Tab(
                        icon: SvgPicture.asset(ImageUtils.getSVGPath('home'),
                          color: mainProvider.currentSelect == 0
                              ? MColors.primary_color
                              : MColors.tabsTextColor,

                        ),
                      ),
                      Tab(
                        icon:  Container(
                         padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: MColors.primary_color,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: SvgPicture.asset(ImageUtils.getSVGPath('scan'),
                            color:  MColors.white,
                          ),
                        ),

                      ),
                      Tab(
                        icon:  SvgPicture.asset(ImageUtils.getSVGPath('profile'),
                          color: mainProvider.currentSelect == 2
                              ? MColors.primary_color
                              : MColors.tabsTextColor,
                        ),
                      ),
                    ],
                    isScrollable: false,
                    indicatorWeight: 0.01,
                    dividerColor: MColors.btn_color,
                    indicatorSize: TabBarIndicatorSize.label,
                    // labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  ),
                ),
              ),
            ),
          );
        },
      )
   ;
  }

  @override
  MainPresenter createPresenter() {
    return MainPresenter();
  }

  @override
  bool get wantKeepAlive => true;

}
