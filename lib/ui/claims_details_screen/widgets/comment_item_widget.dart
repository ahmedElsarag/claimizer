import 'package:Cliamizer/network/models/ClaimDetailsResponse.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../app_widgets/image_loader.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({Key key, this.commentsData}) : super(key: key);
  final CommentsData commentsData;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: ImageLoader(imageUrl: commentsData.user.avatar,height: 48,width: 48,))),
              Gaps.hGap12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50.w,
                    child: Text(commentsData.user?.name?? "",
                        style: MTextStyles.textMain14.copyWith(
                          color: MColors.black,
                        )),
                  ),
                  Gaps.vGap4,
                  Container(
                    width: 50.w,
                    child: Text(commentsData.comment??"",
                        style: MTextStyles.textGray12.copyWith(
                          color: MColors.primary_light_color,
                        )),
                  ),
                  Gaps.vGap4,
                  Text(commentsData.createdAt??"",
                      style: MTextStyles.textGray10.copyWith(
                        color: MColors.black,
                      )),
                  Gaps.vGap12,
                ],
              ),
              Spacer(),
              // InkWell(
              //     onTap:(){
              //       print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ${commentsData.id}");
              //     },
              //     child: SvgPicture.asset(ImageUtils.getSVGPath("trash")))
            ],
          ),
          Visibility(
            visible: commentsData.files !=null,
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
    );
  }
}
