import 'package:flutter/material.dart';
import 'package:Cliamizer/generated/l10n.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:sizer/sizer.dart';

class NoDataWidget extends StatelessWidget {


   NoDataWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 100,
              width: 200,
              child: Opacity(
                opacity: .5,
                child: Image.asset("assets/images/png/logo.png",color: MColors.gray_99,),
              )),
          SizedBox(height: 20),
          Text(
            'sorryNoAvailableResult',
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: MColors.gray_cc),
          ),
          // SpinKitSpinningLines(
          //     color: MColors.gray_99.withOpacity(.5)),
        ],
      ),
    );
  }
}
