import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/app_headline.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class CommentsWidget extends StatelessWidget {
 final String userName;
 final String userImage;
 final String comment;
 final String commentDate;
 final Function deleteComment;
  const CommentsWidget({Key key, this.userName, this.userImage, this.comment, this.commentDate, this.deleteComment,}) : super(key: key);
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
          itemCount: 5,
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
                          child: Image.asset(ImageUtils.getImagePath(userImage??"img"),height: 48,width: 48,))),
                  Gaps.hGap12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName??"",
                          style: MTextStyles.textMain14.copyWith(
                            color: MColors.black,
                          )),
                      Gaps.vGap4,
                      Container(
                        width: 50.w,
                        child: Text(comment??"",
                            style: MTextStyles.textGray12.copyWith(
                              color: MColors.primary_light_color,
                            )),
                      ),
                      Gaps.vGap4,
                      Text(commentDate??"",
                          style: MTextStyles.textGray10.copyWith(
                            color: MColors.black,
                          )),
                      Gaps.vGap12,
                    ],
                  ),
                  Spacer(),
                  InkWell(
                      onTap: deleteComment??(){},
                      child: SvgPicture.asset(ImageUtils.getSVGPath("trash")))
                ],
              ),
              Visibility(
                visible: true,
                child: SizedBox(
                  height: 80,
                  width: 100.w,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
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
