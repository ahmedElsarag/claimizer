import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/app_headline.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/home_screen/HomePresenter.dart';
import 'package:Cliamizer/ui/home_screen/HomeProvider.dart';
import 'package:Cliamizer/ui/home_screen/widgets/home_card_item.dart';
import 'package:Cliamizer/ui/home_screen/widgets/remember_that_item.dart';
import 'package:Cliamizer/ui/main_screens/MainProvider.dart';
import 'package:Cliamizer/ui/notification_screen/NotificationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/model_eventbus/EventBusUtils.dart';
import '../../CommonUtils/model_eventbus/ProfileEvent.dart';
import '../../CommonUtils/model_eventbus/ReloadHomeEevet.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../ClaimsWithFilter/ClaimsWithFilterScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends BaseState<HomeScreen, HomePresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  HomeProvider provider;
  MainProvider mainProvider;
  ClaimsWithFilterProvider claimsProvider;
  List cardsColor = [
    Color(0xff44A4F2),
    Color(0xffFF9500),
    Color(0xff3716EE),
    Color(0xff10D2C8),
    Color(0xff0A562E),
    Color(0xffFF0000),
    Color(0xff679C0D),
  ];

  List<String> cardImages = [
    'allclaims',
    'newclaims',
    'assigned_claims',
    'started_claims',
    'completed_claims',
    'canceled_claims',
    'closed_claims'
  ];

  @override
  void initState() {
    provider = context.read<HomeProvider>();
    mainProvider = context.read<MainProvider>();
    claimsProvider = context.read<ClaimsWithFilterProvider>();
    EventBusUtils.getInstance().on<ProfileEvent>().listen((event) {
      if (event.username != null) {
        provider.name = event.username;
      }
      if (event.userImage != null) {
        provider.avatar = event.userImage;
      }
      setState(() {});
    });
    EventBusUtils.getInstance().on<ReloadEvent>().listen((event) {
      if (event.isRefresh != null || event.isLangChanged != null) {
        mPresenter.getStatisticsApiCall();
      }
      setState(() {});
    });
    mPresenter.getStatisticsApiCall();
    mPresenter.getUserName();
    mPresenter.getUserImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> cardTitles = [
      S.current.allClaims,
      S.current.newClaims,
      S.current.assignedClaims,
      S.current.startedClaims,
      S.current.completedClaims,
      S.current.cancelledClaims,
      S.current.closedClaims
    ];
    return Scaffold(
      backgroundColor: MColors.background_color,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    child: Text("${S.of(context).welcome} ${provider.name ?? ""}",
                        maxLines: 2,
                        style: TextStyle(
                            color: MColors.headline_text_color, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (_) => NotificationScreen()));
                      },
                      child: SvgPicture.asset(
                        ImageUtils.getSVGPath('notification'),
                        width: 8.w,
                        height: 8.w,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(200), child: Image.asset(ImageUtils.getImagePath("logo"))),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            AppHeadline(
              title: S.of(context).statisticsForYourClaims,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            const SizedBox(
              height: 18,
            ),
            Selector<HomeProvider, List<String>>(
              selector: (_, provider) => provider.claimsStatistics,
              builder: (context, list, child) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 16 / 9,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                    7,
                    (index) => GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          claimsProvider.status = "all";
                        } else if (index == 1) {
                          claimsProvider.status = "new";
                        } else if (index == 2) {
                          claimsProvider.status = "assigned";
                        } else if (index == 3) {
                          claimsProvider.status = "started";
                        } else if (index == 4) {
                          claimsProvider.status = "completed";
                        } else if (index == 5) {
                          claimsProvider.status = "cancelled";
                        } else if (index == 6) {
                          claimsProvider.status = "closed";
                        }
                        if (index != 0) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ClaimsWithFilterScreen(),
                              ));
                        } else {
                          mainProvider.tabController = TabController(vsync: this, length: 4, initialIndex: 1);
                          mainProvider.currentSelect = 1;
                          mainProvider.tabController.addListener(() {
                            mainProvider.currentSelect = mainProvider.tabController.index;
                          });
                        }
                      },
                      child: HomeCardItem(
                          cardColor: cardsColor[index],
                          title: cardTitles[index],
                          imageIcon: cardImages[index],
                          value: list.isNotEmpty ? list[index] : ' '),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Visibility(
              visible: provider.rememberThatList.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeadline(title: S.of(context).rememberThat, padding: const EdgeInsets.symmetric(horizontal: 20)),
                  const SizedBox(height: 18),
                  Container(
                    height: 16.h,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) =>
                            RememberThatItem(index: index, aboutToExpireUnits: provider.rememberThatList[index]),
                        separatorBuilder: (_, index) => SizedBox(
                              width: 3.w,
                            ),
                        itemCount: provider.rememberThatList.length),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  HomePresenter createPresenter() {
    return HomePresenter();
  }
}
