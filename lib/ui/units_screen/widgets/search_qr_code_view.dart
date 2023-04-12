import 'package:Cliamizer/ui/units_screen/units_presenter.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';
import 'build_qrcode_field.dart';

class SearchAboutUnitByQR extends StatelessWidget {
  const SearchAboutUnitByQR({Key key, this.provider, this.presenter}) : super(key: key);
  final UnitProvider provider;
  final UnitPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => Container(
        padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
        margin: EdgeInsets.symmetric(vertical: 2.w),
        decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Text(S.current.newLinkRequest, style: MTextStyles.textMain18)),
            Gaps.vGap8,
            Gaps.vGap8,
            Gaps.vGap8,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 1.w,
                  height: 5.w,
                  margin: EdgeInsetsDirectional.only(end: 3.w),
                  decoration: BoxDecoration(color: MColors.primary_color, borderRadius: BorderRadius.circular(4)),
                ),
                Text(S.of(context).unitQuery, style: MTextStyles.textMain16),
              ],
            ),
            Gaps.vGap8,
            Gaps.vGap12,
            BuildQRCodeField(
              provider: provider,
            ),
            Container(
              width: 100.w,
              margin: EdgeInsetsDirectional.only(
                top: 6.w,
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (pr.qrCode.text.isEmpty) {
                    presenter.view.showToasts(S.of(context).pleaseEnterQrCode,'warning');
                  } else {
                    presenter.checkLinkHasParams(pr.qrCode.text);
                    print("QRCODE = ${pr.qrCode.text}");
                  }
                },
                child: Text(
                  S.of(context).search,
                  style: MTextStyles.textMain14.copyWith(fontWeight: FontWeight.w700, color: MColors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
                    elevation: MaterialStatePropertyAll(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
              ),
            ),
            Gaps.vGap8,
            Visibility(
              visible: pr.message != null,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(color: Color(0xffDA1414).withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                child: Text(
                  pr.message??"",
                  style: MTextStyles.textMain14.copyWith(fontSize: 9.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
