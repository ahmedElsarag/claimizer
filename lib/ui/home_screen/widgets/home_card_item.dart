import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeCardItem extends StatelessWidget {
  const HomeCardItem(
      {Key key, @required this.cardColor, @required this.title, @required this.imageIcon, @required this.value})
      : super(key: key);

  final Color cardColor;
  final String title;
  final String imageIcon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 20,
      // margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: cardColor.withOpacity(.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                value,
                style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: cardColor.withOpacity(.15)),
                child: SvgPicture.asset(
                  ImageUtils.getSVGPath(imageIcon),
                  width: 14,
                  height: 14,
                ),
              )
            ],
          ),
          Spacer(),
          Text(
            title,
            style: TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
