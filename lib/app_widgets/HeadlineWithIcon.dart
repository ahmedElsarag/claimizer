import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuildHeadline extends StatelessWidget {
  const BuildHeadline({
    @required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      height: 3.h,
      child: Row(
        children: [
          Text(
            text,
            /*textScaleFactor: 1,*/
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
