import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/comments_widget.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/description_widget.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/files_widgets.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/app_headline.dart';
import '../../app_widgets/claimizer_app_bar.dart';
import '../../generated/l10n.dart';
import '../../network/models/claims_response.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import 'ClaimsDetailsPresenter.dart';
import 'ClaimsDetailsProvider.dart';

class ClaimsDetailsScreen extends StatefulWidget {
  static const String TAG = "/ClaimsDetailsScreen";
  final int id;
  final ClaimsDataBean claimsDataBean;

  ClaimsDetailsScreen({
    Key key,
    this.id,
    this.claimsDataBean,
  }) : super(key: key);

  @override
  State<ClaimsDetailsScreen> createState() => ClaimsDetailsScreenState();
}

class ClaimsDetailsScreenState extends BaseState<ClaimsDetailsScreen, ClaimsDetailsPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  ClaimsDetailsProvider provider = ClaimsDetailsProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 6.w),
                          margin: EdgeInsets.symmetric(vertical: 2.w),
                          decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppHeadline(title: widget.claimsDataBean.unit.building ?? S.current.na),
                              Gaps.vGap30,
                              ItemWidget(
                                title: S.current.yourBuilding,
                                value: widget.claimsDataBean.unit.building ?? S.current.na,
                              ),
                              ItemWidget(
                                title: S.current.yourUnit,
                                value: widget.claimsDataBean.unit.name ?? S.current.na,
                              ),
                              ItemWidget(
                                title: S.current.claimCategory,
                                value: widget.claimsDataBean.category.name ?? S.current.na,
                              ),
                              ItemWidget(
                                title: S.current.claimSubCategory,
                                value: widget.claimsDataBean.subCategory.name ?? S.current.na,
                              ),
                              ItemWidget(
                                title: S.current.claimType,
                                value: widget.claimsDataBean.type.name ?? S.current.na,
                              ),
                              ItemWidget(
                                title: S.current.availableTime,
                                value:
                                "${widget.claimsDataBean?.availableDate.toString()??S.current.na} - ${widget.claimsDataBean?.availableTime??S.current.na}",
                              ),
                              ItemWidget(
                                title: S.current.createdAt,
                                value: widget.claimsDataBean?.createdAt,
                                valueColor: MColors.primary_light_color,
                              ),
                              DescriptionWidget(
                                value:widget.claimsDataBean?.description
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
                                  print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@comment deleted");
                                },
                              ),
                              InkWell(
                                onTap: () {
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
