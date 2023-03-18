import 'package:flutter/material.dart';

import '../res/colors.dart';

class AppHeadline extends StatelessWidget {
  const AppHeadline({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 6),
            width: 3.5,
            height: 16,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.red),
          ),
          SizedBox(
            width: 6,
          ),
          Text(title,
              maxLines: 1,
              style: TextStyle(color: MColors.headline_text_color, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
