import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({Key key, this.height, @required this.itemBuilder, @required this.itemCount, }) : super(key: key);

  final double height;
  final Function(int) itemBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height??20.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder:(ctx,index)=> itemBuilder(index),
          separatorBuilder: (ctx,index)=>SizedBox(width: 14,),
          itemCount: itemCount),
    );
  }
}
