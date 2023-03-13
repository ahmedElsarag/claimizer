import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:Cliamizer/CommonUtils/image_utils.dart';

import '../../../res/colors.dart';

class bannerSliderComponent extends StatefulWidget {
  const bannerSliderComponent({Key key, @required this.topSlider})
      : super(key: key);
  final List<String> topSlider;
  @override
  bannerSliderComponentState createState() => bannerSliderComponentState();
}

class bannerSliderComponentState extends State<bannerSliderComponent> {

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [bannerSlider(context), indicator(context)]);
  }

  Widget bannerSlider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CarouselSlider(
        options: CarouselOptions(
          // height:double.infinity ,
          initialPage: 0, //frist image
          enableInfiniteScroll: true, //scroll lw7dh
          reverse: false,
          aspectRatio: 4,
          viewportFraction: 0.85,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          enlargeCenterPage: false,
          onPageChanged: ((index, reason) {
            setState(() {
              this.index=index;
            });
          }),
          scrollDirection: Axis.horizontal,
        ),
        items: widget.topSlider.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  child: Image.asset(
                ImageUtils.getImagePath(i),
                fit: BoxFit.fitHeight,
              ));
              // return Image(
              //   image: NetworkImage('${i.categoryPhoto}'),
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget indicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Center(
          child: AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
          activeDotColor: MColors.orange,
          dotColor:MColors.white5.withAlpha(50),
          dotHeight: 6,
          dotWidth: 15,
          expansionFactor: 2,
          spacing: 5,
        ),
        count: widget.topSlider.length,
        activeIndex: index,
      )),
    );
  }
}
