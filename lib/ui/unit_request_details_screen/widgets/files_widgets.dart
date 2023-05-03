import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/app_widgets/image_loader.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';

class FilesWidget extends StatelessWidget {
  final List<String> apiStrings;
  final int count;

  const FilesWidget({Key key, this.count, this.apiStrings}) : super(key: key);

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).allFiles,
            style: MTextStyles.textMain16.copyWith(
              color: MColors.black,
            )),
        Gaps.vGap12,
        SizedBox(
          height: 74,
          child: apiStrings.isNotEmpty ?  ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: count,
            itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                child: ImageLoader(
                  imageUrl: apiStrings[index],
                  width: 16.w,
                  height: 16.w,
                )),
          ): Text(S.of(context).noFiles),
        ),
        Gaps.vGap12,
      ],
    );
  }
}
