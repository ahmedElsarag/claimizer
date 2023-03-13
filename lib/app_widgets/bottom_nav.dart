import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../generated/l10n.dart';
import '../res/colors.dart';


class GadawlBottomNavigationBar extends StatelessWidget {
  final  provider;
  final TabController tabController;
  const GadawlBottomNavigationBar({this.provider,this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:8.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0)),
        boxShadow: [
          BoxShadow(
            color: MColors.gray_ce.withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        tabs: [
          Tab(
            icon: Image.asset(
              "assets/images/homepage.png",
              width: 5.w,
              color: provider.currentTabSelect == 0
                  ? MColors.primary_color
                  : MColors.tabsTextColor,
            ),
            child: Text(
             'home',
              style: TextStyle(
                  color: provider.currentTabSelect  == 0
                      ? MColors.primary_color
                      : MColors.tabsTextColor,
                  fontSize: 8.sp),
              maxLines: 1,
            ),
          ),
          Tab(
            icon: Image.asset(
              "assets/images/invoice.png",
              width: 5.w,
              color: provider.currentTabSelect  == 1
                  ? MColors.primary_color
                  : MColors.tabsTextColor,
            ),
            child: Text(
              'invoices',
              style: TextStyle(
                  color: provider.currentTabSelect  == 1
                      ? MColors.primary_color
                      : MColors.tabsTextColor,
                  fontSize: 8.sp),
              maxLines: 1,
            ),
          ),
          Tab(
            icon: Image.asset(
              "assets/images/cubes.png",
              color: provider.currentTabSelect  == 2
                  ? MColors.primary_color
                  : MColors.tabsTextColor,
              width: 5.w,
            ),
            child: Text(
              'products',
              style: TextStyle(
                  color: provider.currentTabSelect  == 2
                      ? MColors.primary_color
                      : MColors.tabsTextColor,
                  fontSize: 8.sp),
              maxLines: 1,
            ),

          ),
          Tab(
            icon: Image.asset(
              "assets/images/apps.png",
              color: provider.currentTabSelect  == 3
                  ? MColors.primary_color
                  : MColors.tabsTextColor,
              width: 5.w,
            ),
            child: Text(
              'more',

              style: TextStyle(
                  color: provider.currentTabSelect  == 3
                      ? MColors.primary_color
                      : MColors.tabsTextColor,
                  fontSize: 8.sp),
              maxLines: 1,
            ),
          ),
        ],
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).primaryColor,
        labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
      ),
    );
  }
}
