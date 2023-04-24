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
    // mPresenter.getNotificationApiCall();
  }

  final List<Map<String, dynamic>> data = [
    {
      "date": "Today -  10,June,2023",
      "items": [
        {
          "id": 1,
          "title": "Message head",
          "description": "Your serial is successfully added in app list. Serial number is 25 you before 15 minutes",
          "time": "since 2 weeks"
        },
        {
          "id": 2,
          "title": "Message head",
          "description": "Your serial is successfully added in app list. Serial number is 25 you before 15 minutes",
          "time": "since 2 weeks"
        }
      ]
    },
    {
      "date": "Yesterday -  9,June,2023",
      "items": [
        {
          "id": 3,
          "title": "Message head",
          "description": "Your serial is successfully added in app list. Serial number is 25 you before 15 minutes",
          "time": "since 2 weeks"
        }
      ]
    },
    {
      "date": "Monday -  6,June,2023",
      "items": [
        {
          "id": 4,
          "title": "Message head",
          "description": "Your serial is successfully added in app list. Serial number is 25 you before 15 minutes",
          "time": "since 2 weeks"
        },
        {
          "id": 5,
          "title": "Message head",
          "description": "Your serial is successfully added in app list. Serial number is 25 you before 15 minutes",
          "time": "since 2 weeks"
        },
        {
          "id": 6,
          "title": "Message head",
          "description": "Your serial is successfully added in app list. Serial number is 25 you before 15 minutes",
          "time": "since 2 weeks"
        }
      ]
    }
  ];
  List _elements = [
    {'name': 'John', 'group': 'Today -  10,June,2023'},
    {'name': 'John', 'group': 'Today -  10,June,2023'},
    {'name': 'John', 'group': 'Today -  10,June,2023'},
    {'name': 'John', 'group': 'Today -  10,June,2023'},
    {'name': 'Will', 'group': 'Today -  11,June,2023'},
    {'name': 'Beth', 'group': 'Today -  11,June,2023'},
    {'name': 'Miranda', 'group': 'Today -  11,June,2023'},
    {'name': 'Miranda', 'group': 'Today -  11,June,2023'},
    {'name': 'Miranda', 'group': 'Today -  11,June,2023'},
    {'name': 'Mike', 'group': 'Today -  12,June,2023'},
    {'name': 'Danny', 'group': 'Today -  12,June,2023'},
    {'name': 'Danny', 'group': 'Today -  12,June,2023'},
    {'name': 'Danny', 'group': 'Today -  12,June,2023'},
    {'name': 'Danny', 'group': 'Today -  12,June,2023'},
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationProvider>(
      create: (context) => provider,
      builder: (context, child) => Consumer<NotificationProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MColors.page_background,
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
            child: Column(
              children: [
                ClaimizerAppBar(title: S.current.notification),
                Gaps.vGap12,
                Expanded(
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
                ),
                // Expanded(
                //     child: ListView.builder(
                //       itemCount: data.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         final item = data[index];
                //         return Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                //               child: Text(
                //                 item["date"],
                //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: MColors.main_text_color),
                //               ),
                //             ),
                //             Gaps.vGap16,
                //             Container(
                //               decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
                //               child: ListView.builder(
                //                 shrinkWrap: true,
                //                 physics: NeverScrollableScrollPhysics(),
                //                 itemCount: item["items"].length,
                //                 itemBuilder: (BuildContext context, int index) {
                //                   final subItem = item["items"][index];
                //                   return Container(
                //                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                //                     child: Row(
                //                       children: [
                //                         Container(
                //                           height: 32,
                //                           width: 32,
                //                           decoration: BoxDecoration(color: MColors.page_background, borderRadius: BorderRadius.circular(16)),
                //                           padding: EdgeInsets.all(6),
                //                           child: SvgPicture.asset(ImageUtils.getSVGPath("notification-bing")),
                //                         ),
                //                         Gaps.hGap16,
                //                         Column(
                //                           crossAxisAlignment: CrossAxisAlignment.start,
                //                           children: [
                //                             Text(
                //                               subItem["title"],
                //                               style: MTextStyles.textDark14,
                //                             ),
                //                             Gaps.vGap6,
                //                             SizedBox(
                //                                 width: 70.w,
                //                                 child: Text(
                //                                   subItem["description"],
                //                                   style: MTextStyles.textGray12,
                //                                 )),
                //                             Gaps.vGap6,
                //                             Text(
                //                               subItem["time"],
                //                               style: MTextStyles.textDark12,
                //                             ),
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   );
                //                 },
                //               ),
                //             ),
                //             Gaps.vGap16,
                //             Gaps.vGap8
                //           ],
                //         );
                //       },
                //     ))
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
