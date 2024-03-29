import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class HomeCardItem extends StatelessWidget {
  const HomeCardItem(
      {Key key, @required this.cardColor, @required this.title, @required this.imageIcon, @required this.value, this.onTap})
      : super(key: key);

  final Color cardColor;
  final String title;
  final String imageIcon;
  final Function onTap;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: cardColor.withOpacity(.1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AutoSizeText(
                  value,
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: cardColor.withOpacity(.15)),
                  child: SvgPicture.asset(
                    ImageUtils.getSVGPath(imageIcon),
                    width: 5.w,
                    height: 5.w,
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              width: 90.w,
              child: AutoSizeText(
                title,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.w500, color: cardColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
