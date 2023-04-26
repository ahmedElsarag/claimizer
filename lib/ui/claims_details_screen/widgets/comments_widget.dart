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
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(vertical: 2.w),
          child:Column(
            children: [
              Row(
                children: [
                  Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: ImageLoader(imageUrl: commentsData.data[index].user.avatar,height: 48,width: 48,))),
                  Gaps.hGap12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.w,
                        child: Text(commentsData.data[index].user?.name??"",
                            style: MTextStyles.textMain14.copyWith(
                              color: MColors.black,
                            )),
                      ),
                      Gaps.vGap4,
                      Container(
                        width: 50.w,
                        child: Text(commentsData.data[index].comment??"",
                            style: MTextStyles.textGray12.copyWith(
                              color: MColors.primary_light_color,
                            )),
                      ),
                      Gaps.vGap4,
                      Text(commentsData.data[index].createdAt??"",
                          style: MTextStyles.textGray10.copyWith(
                            color: MColors.black,
                          )),
                      Gaps.vGap12,
                    ],
                  ),
                  Spacer(),
                  // InkWell(
                  //     onTap:(){
                  //       print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${commentsData.data[index].id}");
                  //     },
                  //     child: SvgPicture.asset(ImageUtils.getSVGPath("trash")))
                ],
              ),
              Visibility(
                visible: true,
                child: SizedBox(
                  height: 80,
                  width: 100.w,
                  child:  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(ImageUtils.getImagePath("img"),height: 58,width: 58,)),
                    ),),
                ),)
            ],
          ),
        ),),
        Gaps.vGap12,
        Gaps.vGap12,
      ],
    );
  }
}
