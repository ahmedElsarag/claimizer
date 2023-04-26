import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/res/styles.dart';
import 'package:Cliamizer/ui/notification_screen/NotificationPresenter.dart';
import 'package:Cliamizer/ui/notification_screen/NotificationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/claimizer_app_bar.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';

class NotificationScreen extends StatefulWidget {
  static const String TAG = "/NotificationScreen";

  NotificationScreen({
    Key key,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends BaseState<NotificationScreen, NotificationPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  NotificationProvider provider = NotificationProvider();

  @override
  void initState() {
    super.initState();
    mPresenter.getNotificationApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationProvider>(
      create: (context) => provider,
      builder: (context, child) => Consumer<NotificationProvider>(
        builder: (context, pr, child) => Scaffold(
          backgroundColor: MColors.page_background,
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
            child: Column(
              children: [
                ClaimizerAppBar(title: S.current.notification),
                Gaps.vGap12,
                /*Expanded(
                  child:  GroupedListView<dynamic, String>(
                    elements: _elements,
                    groupBy: (element) => element['group'],
                    groupComparator: (value1, value2) => value2.compareTo(value1),
                    itemComparator: (item1, item2) =>
                        item1['name'].compareTo(item2['name']),
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: false,
                    groupSeparatorBuilder: (String value) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: MColors.main_text_color),
                                    ),
                                  ),
                    itemBuilder: (c, element) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                      decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: MColors.page_background, borderRadius: BorderRadius.circular(16)),
                              padding: EdgeInsets.all(6),
                              child: SvgPicture.asset(ImageUtils.getSVGPath("notification-bing")),
                            ),
                            Gaps.hGap16,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  element['name'],
                                  style: MTextStyles.textDark14,
                                ),
                                Gaps.vGap6,
                                SizedBox(
                                    width: 70.w,
                                    child: Text(
                                      element['name'],
                                      style: MTextStyles.textGray12,
                                    )),
                                Gaps.vGap6,
                                Text(
                                  element['name'],
                                  style: MTextStyles.textDark12,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),*/
                Expanded(
                    child: ListView.builder(
                      itemCount: pr.notificationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Text(
                                "${pr.notificationList[index].date} - ${pr.notificationList[index].diffDate}" ,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: MColors.main_text_color),
                              ),
                            ),
                            Gaps.vGap16,
                            Container(
                              decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: pr.notificationList[index].items.length,
                                itemBuilder: (BuildContext context, int nIndex) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(color: MColors.page_background, borderRadius: BorderRadius.circular(16)),
                                          padding: EdgeInsets.all(6),
                                          child: SvgPicture.asset(ImageUtils.getSVGPath("notification-bing")),
                                        ),
                                        Gaps.hGap16,
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 70.w,
                                                child: Text(
                                                  pr.notificationList[index].items[nIndex].title,
                                                  style: MTextStyles.textDark14,
                                                ),),
                                            Gaps.vGap6,
                                            Text(
                                              pr.notificationList[index].diffDate,
                                              style: MTextStyles.textDark12,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Gaps.vGap16,
                            Gaps.vGap8
                          ],
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  NotificationPresenter createPresenter() {
    return NotificationPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
