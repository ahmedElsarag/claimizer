import 'package:flutter/material.dart';

import '../../../res/colors.dart';

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;

  const Indicator({this.currentIndex, this.positionIndex});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      color: positionIndex == currentIndex
          ? MColors.primary_color
          : MColors.primary_color.withOpacity(.1),
      size: 10,
    );
  }
}
