import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ClaimsLoading extends StatelessWidget {
  const ClaimsLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      alignment: Alignment.center,
      child: Lottie.asset('assets/images/png/loading.json', width: 10.w),
    );
  }
}
