import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/colors.dart';

class AppHeadline extends StatelessWidget {
  const AppHeadline({Key key, @required this.title, this.padding=EdgeInsets.zero}) : super(key: key);

  final String title;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 6),
            width: 3.5,
            height: 16,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.red),
          ),
          SizedBox(
            width: 12,
          ),
          AutoSizeText(title,
              maxLines: 1,
              style: TextStyle(color: MColors.headline_text_color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
