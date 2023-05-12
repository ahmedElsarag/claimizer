import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/app_headline.dart';
import 'package:Cliamizer/app_widgets/image_loader.dart';
import 'package:Cliamizer/network/models/ClaimDetailsResponse.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';
import '../ClaimsDetailsPresenter.dart';
import 'comment_item_widget.dart';

class CommentsWidget extends StatelessWidget {
 final Comments commentsData;
 final String claimId;
 final ClaimsDetailsPresenter presenter;
 const CommentsWidget({Key key, this.presenter,this.commentsData, this.claimId,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHeadline(title: S.of(context).topUpdates),
        Gaps.vGap12,
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: commentsData.data.length,
          separatorBuilder: (context, index) => Divider(color: MColors.dividerColor,),
          itemBuilder: (context, index) => ClaimCommentItemWidget(
            apiStrings: commentsData.data[index].files,
            commentsData: commentsData.data[index],
          )),
        Gaps.vGap12,
        Gaps.vGap12,
      ],
    );
  }
}
