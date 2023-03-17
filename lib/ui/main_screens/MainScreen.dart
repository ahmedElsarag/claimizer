import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/qr_screen/qr_screen.dart';
import '../../CommonUtils/image_utils.dart';
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

  @override
  void initState() {
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
                controller: mainProvider.tabController,
                children: [
                  HomeScreen(),
                  QrScreen(),
                  HomeScreen(),
                  HomeScreen(),
                ],
              ),
              bottomNavigationBar: Container(
                height: 8.h,
                padding: EdgeInsets.only(top: 1.h, left: 1.w, right: 1.w),
                color: MColors.white,
                child: TabBar(
                  controller: mainProvider.tabController,
                  labelStyle: TextStyle(fontSize: 12),
                  isScrollable: false,
                  unselectedLabelColor:  MColors.subText_color,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      icon: SvgPicture.asset(ImageUtils.getSVGPath('home'),
                        color: mainProvider.currentSelect == 0
                            ? MColors.primary_color
                            : MColors.tabsTextColor,

                      ),
                      text: 'Home',
                    ),
                    Tab(
                      icon:  SvgPicture.asset(ImageUtils.getSVGPath('claims'),
                        color: mainProvider.currentSelect == 1
                            ? MColors.primary_color
                            : MColors.tabsTextColor,
                      ),
                      text: 'Claims',
                    ),
                    Tab(
                      icon:  SvgPicture.asset(ImageUtils.getSVGPath('units'),
                        color: mainProvider.currentSelect == 2
                            ? MColors.primary_color
                            : MColors.tabsTextColor,
                      ),
                      text: 'Units',
                    ),
                    Tab(
                      icon:  Icon(Icons.more_horiz_rounded,
                        color: mainProvider.currentSelect == 3
                            ? MColors.primary_color
                            : MColors.tabsTextColor,
                      ),
                      text: 'More',
                    ),
                  ],
                  // labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
