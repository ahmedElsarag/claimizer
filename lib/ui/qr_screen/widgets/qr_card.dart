import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../app_widgets/TextWidgets.dart';
import '../../../res/colors.dart';

class QrCard extends StatelessWidget {
  const QrCard({Key key, @required this.imagePath,@required this.title}) : super(key: key);

  final String imagePath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
          color: MColors.btn_color,
          borderRadius: BorderRadius.circular(18)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(ImageUtils.getSVGPath(imagePath)),
          SizedBox(height: 2.h,),
          boldText(title,fontSize: 12.sp,color: MColors.light_text_color)
        ],
      ),
    );
  }
}
