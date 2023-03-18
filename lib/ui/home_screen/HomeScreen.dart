import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/app_headline.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/home_screen/HomePresenter.dart';
import 'package:Cliamizer/ui/home_screen/HomeProvider.dart';
import 'package:Cliamizer/ui/home_screen/widgets/home_card_item.dart';
import 'package:Cliamizer/ui/home_screen/widgets/remember_that_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../res/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends BaseState<HomeScreen, HomePresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  HomeProvider provider;
  List cardsColor = [
    Color(0xff44A4F2),
    Color(0xffFF9500),
    Color(0xff3716EE),
    Color(0xff10D2C8),
    Color(0xff0A562E),
    Color(0xffFF0000),
    Color(0xff679C0D),
  ];

  List<String> cardTitles = [
    'All Claims',
    'New Claims',
    'Assigned Claims',
    'Started Claims',
    'Completed Claims',
    'Cancelled Claims',
    'Closed Claims'
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
    mPresenter.getStatisticsApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Text('Welcome, Ahmed Elsarag',
                        maxLines: 2,
                        style: TextStyle(
                            color: MColors.headline_text_color, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ),
                  Spacer(),
                  SvgPicture.asset(ImageUtils.getSVGPath('notification')),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            AppHeadline(title: 'Statistics For Your Claims'),
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
                    (index) => HomeCardItem(
                        cardColor: cardsColor[index],
                        title: cardTitles[index],
                        imageIcon: cardImages[index],
                        value: list.isNotEmpty ? list[index] : ' '),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            AppHeadline(title: 'Remember That'),
            const SizedBox(height: 18),
            Container(
              height: 130,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => RememberThatItem(index: index),
                  separatorBuilder: (_, index) => SizedBox(
                        width: 3.w,
                      ),
                  itemCount: 5),
            ),
            const SizedBox(height: 40),

            // Container(
            //   margin: EdgeInsets.all(20),
            //   padding: EdgeInsets.all(20),
            //   width: double.maxFinite,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.white
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text('Towe A5 - Owned',style: TextStyle(fontSize: 16,fontWeight:FontWeight.w600,color: Colors.black),),
            //               SizedBox(height: 4,),
            //               Text('Request Code #123-45-567',style: TextStyle(fontSize: 12,fontWeight:FontWeight.w500,color: Colors.black45),),
            //             ],
            //           ),
            //           Spacer(),
            //           Container(
            //             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(14),
            //                 color: Colors.blue.withOpacity(.2)
            //             ),
            //             child: Text('New',style: TextStyle(fontSize: 14,color: Colors.blue),),
            //           )
            //         ],
            //       ),
            //       SizedBox(height: 16,),
            //       Divider(height: 1,color: Colors.black,),
            //       SizedBox(height: 16,),
            //       Row(
            //         children: [
            //           Text('Unit Name',style: TextStyle(fontSize: 12,color: Colors.black54),),
            //           Spacer(),
            //           Text('Tower A5 - Owned',style: TextStyle(fontSize: 12,color: Colors.black45),),
            //         ],
            //       ),
            //       SizedBox(height: 16,),
            //       Divider(height: 1,color: Colors.black,),
            //       SizedBox(height: 16,),
            //     ],
            //   ),
            // ),
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
