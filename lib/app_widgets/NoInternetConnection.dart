import 'package:flutter/cupertino.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../generated/l10n.dart';

class NoInternetConnection extends StatelessWidget {
  final Function onTap;

  const NoInternetConnection({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/images/png/internet.json',
                width: 40.w, height: 40.w),
            SizedBox(
              height: 4.h,
            ),
            Text(
              'oopsNoInternetConnection',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'makeSureWifiOrCellularDataIsTurnedOnAnd',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.sp,
                color: MColors.gray_66
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            // SizedBox(
            //     width: 30.w,
            //     height: 10.h,
            //     child: DefaultButton(
            //       txt: S.of(context).tryagain,
            //       onTapped: onTap,
            //     ))
          ],
        ),
      ),
    );
  }
}
