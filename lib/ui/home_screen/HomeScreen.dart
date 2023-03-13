import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/headline.dart';
import 'package:Cliamizer/app_widgets/horizontal_list.dart';
import 'package:Cliamizer/ui/home_screen/widgets/bannerSliderComponent.dart';
import 'package:Cliamizer/ui/home_screen/widgets/home_list_item.dart';
import 'package:Cliamizer/ui/home_screen/widgets/top_shape.dart';

import '../../app_widgets/TextWidgets.dart';
import '../../res/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;
  final List<String> topSlider = ["offer1", "offer2"];
  final List<String> lastOffers = ["last_offer1", "last_offer2"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.secondary_color,
      body: ContainerShape(
        child: SingleChildScrollView(
          child: Column(
            children: [
              navigationBar(),
              SizedBox(
                height: 20,
              ),
              bannerSliderComponent(
                topSlider: topSlider,
              ),
              SizedBox(
                height: 20,
              ),
              HeadLine(
                isSuffix: true,
                prefixText: 'The Latest Offers',
                suffixText: 'See all',
                padding: EdgeInsets.all(20),
              ),
              HorizontalList(
                itemBuilder: (index) => HomeListItem(
                  index: index,
                  imagePath: lastOffers[index],
                  length: lastOffers.length,
                ),
                itemCount: lastOffers.length,
              ),
              HeadLine(
                isSuffix: false,
                prefixText: 'Bundles & Packages',
                padding: EdgeInsets.all(20),
              ),
              HorizontalList(
                height: 15.h,
                  itemBuilder: ( index) => HomeListItem(imagePath: 'package',width: 22.w,index: index,length: 5),
                  itemCount: 5
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget navigationBar() {
  return Container(
    height: 80,
    padding: const EdgeInsets.only(left: 22, right: 22, top: 25),
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              userPhotoButton(),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText("Welcome!", color: MColors.white),
                    boldText("Abdu Rahim", color: MColors.yellow),
                  ],
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: notificationsButton(),
        )
      ],
    ),
  );
}

Widget userPhotoButton({double width, double height}) => Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(2),
      // Border width
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(22), // Image radius
          child: Image.asset(ImageUtils.getImagePath('user'), fit: BoxFit.cover),
        ),
      ),
    );

Widget notificationsButton() => Container(
      width: 45,
      height: 45,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: MColors.primary_light_color, borderRadius: BorderRadius.circular(8)),
      child: SvgPicture.asset(
        ImageUtils.getSVGPath('notification'),
        fit: BoxFit.fitWidth,
      ),
    );
