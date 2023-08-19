import 'package:Cliamizer/ui/claims_screen/ClaimsPresenter.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../generated/l10n.dart';
import '../../../network/models/claim_request_response.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class ClaimCreatedDialog extends StatelessWidget {
  const ClaimCreatedDialog({Key key, this.presenter, this.claimsRequestResponse}) : super(key: key);
 final ClaimsRequestResponse claimsRequestResponse;
 final ClaimsPresenter presenter;
  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (ctx, pr, w) => AlertDialog(
        insetPadding: EdgeInsets.all(20),
        contentPadding: EdgeInsets.all(16),
        backgroundColor: MColors.whiteE,
        elevation: 0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(ImageUtils.getSVGPath("done")),
            Gaps.vGap16,
            Text(S.of(context).confirmation,
                style: MTextStyles.textMain16.copyWith(
                  color: MColors.black,
                )),
            Gaps.vGap8,
            Text(
              S.of(context).thankYouForSubmittingYourRequestOneOfOurCustomerservices,
              style: MTextStyles.textSubtitle,
              textAlign: TextAlign.center,
            ),
            Gaps.vGap8,
            Text(
              '${S.of(context).requestCode} ${claimsRequestResponse?.id}'  ,
              style: MTextStyles.textSubtitle,
              textAlign: TextAlign.center,
            ),
            Gaps.vGap30,
            ElevatedButton(
              onPressed: () {
                pr.isStepsFinished = !pr.isStepsFinished;
                pr.selectedIndex = 1;
                pr.currentStep = 0;
                presenter.getClaims();
                Navigator.pop(context);
              },
              child: Text(
                S.of(context).backToHome,
                style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
                  elevation: MaterialStatePropertyAll(0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
            )
          ],
        ),
      ),
    );
  }
}
