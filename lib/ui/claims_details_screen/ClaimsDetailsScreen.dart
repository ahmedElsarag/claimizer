import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/comments_widget.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/description_widget.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/files_widgets.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/LanguageProvider.dart';
import '../../CommonUtils/time_format_util.dart';
import '../../app_widgets/CustomTextField.dart';
import '../../app_widgets/app_headline.dart';
import '../../app_widgets/claimizer_app_bar.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import '../edit_profile_screen/EditProfileScreen.dart';
import 'ClaimsDetailsPresenter.dart';
import 'ClaimsDetailsProvider.dart';

class ClaimsDetailsScreen extends StatefulWidget {
  static const String TAG = "/ClaimsDetailsScreen";
  final int id;
  ClaimsDetailsScreen({
    Key key, this.id,
  }) : super(key: key);

  @override
  State<ClaimsDetailsScreen> createState() => ClaimsDetailsScreenState();
}

class ClaimsDetailsScreenState
    extends BaseState<ClaimsDetailsScreen, ClaimsDetailsPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  ClaimsDetailsProvider provider = ClaimsDetailsProvider();
  final DateFormat _dateFormatEN = DateFormat('dd/MM/yyyy', 'en');
  final DateFormat _dateFormatAR = DateFormat('yyyy/MM/dd', 'ar');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    super.build(context);
    return Consumer<ClaimsDetailsProvider>(
        builder: (context, pr, child) => Scaffold(
              backgroundColor: MColors.page_background,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                  child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClaimizerAppBar(title: S.of(context).claimDetails),
                        Gaps.vGap12,
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.w, horizontal: 6.w),
                          margin: EdgeInsets.symmetric(vertical: 2.w),
                          decoration: BoxDecoration(
                              color: MColors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppHeadline(title: "Falcon Tower A5 - Owned"),
                              Gaps.vGap30,
                              ItemWidget(
                                title: S.current.yourBuilding,
                                value: "repudiandae molestias facilis",
                              ),
                              ItemWidget(
                                title: S.current.yourUnit,
                                value: "repudiandae molestias facilis",
                              ),
                              ItemWidget(
                                title: S.current.claimCategory,
                                value: "repudiandae molestias facilis",
                              ),
                              ItemWidget(
                                title: S.current.claimSubCategory,
                                value: "repudiandae molestias facilis",
                              ),
                              ItemWidget(
                                title: S.current.claimType,
                                value: "repudiandae molestias facilis",
                              ),
                              ItemWidget(
                                title: S.current.availableTime,
                                value:
                                    "${languageProvider.locale == Locale("en") ? _dateFormatEN.format(DateTime.now()) : _dateFormatAR.format(DateTime.now())} ${S.of(context).from} ${TimeFormatUtil.formatTimeOfDay(TimeOfDay.now())}",
                              ),
                              ItemWidget(
                                title: S.current.createdAt,
                                value: "22-1815-060323-152",
                                valueColor: MColors.primary_light_color,
                              ),
                              DescriptionWidget(
                                value:
                                    "Minus aut a id. Tempore sequi laborum et provident eligendi quidem doloremque rerum. Quisquam laboriosam tempora minima. Odio et ea suscipit consequatur.",
                              ),
                              FilesWidget(
                                value: ImageUtils.getImagePath("logo"),
                              ),
                              CommentsWidget(
                                userName: "Ahmed Mohamed",
                                userImage: "img",
                                comment: "Claim Set Employee : mohammad",
                                commentDate: "23-03-2023 10:20",
                                deleteComment: () {
                                  print(
                                      "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@comment deleted");
                                },
                              ),
                              InkWell(
                                onTap: (){
                                  print("@@@@@@@@@@@@@@@@@@@@@@ Updated");
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      ImageUtils.getSVGPath("refresh"),
                                    ),
                                    Gaps.hGap8,
                                    Text(
                                      "Update",
                                      style: MTextStyles.textMain14,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ));
  }

  @override
  ClaimsDetailsPresenter createPresenter() {
    return ClaimsDetailsPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
