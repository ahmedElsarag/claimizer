import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/FullScreenImage.dart';
import '../../../CommonUtils/image_utils.dart';
import '../../../app_widgets/image_loader.dart';
import '../../../network/models/UnitRequestDetailsResponse.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({Key key, this.commentsData, this.apiStrings}) : super(key: key);
  final Comments commentsData;
  final List<String> apiStrings;
  String formatDate(String date){
    String dateTimeString = date;
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateString = DateFormat("dd-MM-yyyy | hh:mm a").format(dateTime.toLocal());
    return formattedDateString;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> stringWidgets = [];

    for (String apiString in apiStrings) {
      // extract values from apiString and add them to a widget
      stringWidgets.add(ImageLoader(
        imageUrl: apiString,
        width: 16.w,
        height: 16.w,
      ));
    }
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
                    child: Text(commentsData.content??"",
                        style: MTextStyles.textGray12.copyWith(
                          color: MColors.primary_light_color,
                        )),
                  ),
                  Gaps.vGap4,
                  Text(formatDate(commentsData.createdAt??""),
                      style: MTextStyles.textGray10.copyWith(
                        color: MColors.black,
                      )),
                  Gaps.vGap12,
                ],
              ),
              Spacer(),
            ],
          ),
          apiStrings.isNotEmpty? SizedBox(
            height: 80,
            width: 100.w,
            child:  ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: apiStrings.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FullScreenImage(image: apiStrings[index],);
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ImageLoader(imageUrl: apiStrings[index],height: 58,width: 58,)),
                ),
              ),),
          ) :SizedBox.shrink()
        ],
      ),
    );
  }
}
