import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';

class HomeListItem extends StatelessWidget {
   HomeListItem({Key key, this.index, this.imagePath, this.length, this.width}) : super(key: key);

  final int index;
  final String imagePath;
  final int length;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??90.w,
      margin: EdgeInsetsDirectional.only(start:index==0?20:0,end: index==length-1?20:0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(ImageUtils.getImagePath(imagePath),fit: BoxFit.cover,),
      ),

    );
  }
}
