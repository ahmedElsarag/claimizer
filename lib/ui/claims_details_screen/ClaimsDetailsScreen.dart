import 'dart:io';
import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/CommonUtils/utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/build_comment_field.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/build_upload_file_field.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/comments_widget.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/description_widget.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/files_widgets.dart';
import 'package:Cliamizer/ui/claims_details_screen/widgets/item_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
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
  ClaimsDetailsProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<ClaimsDetailsProvider>();
    mPresenter.getClaimDetailsDataApiCall(widget.claimsDataBean.referenceId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ClaimsDetailsProvider>(builder: (context, pr, child) {
      return Scaffold(
        backgroundColor: MColors.page_background,
        body: pr.instance != null
            ? SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                  child: ListView(children: [
                    ClaimizerAppBar(title: S.of(context).claimDetails),
                    Gaps.vGap12,
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 6.w),
                      margin: EdgeInsets.symmetric(vertical: 2.w),
                      decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppHeadline(title: pr.instance?.unit?.building ?? S.current.na),
                          Gaps.vGap30,
                          ItemWidget(
                            title: S.current.yourBuilding,
                            value: pr.instance?.unit?.building ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.yourUnit,
                            value: pr.instance.unit.name ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.of(context).claimStatus,
                            value: pr.instance.status ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.claimCategory,
                            value: pr.instance.category.name ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.claimSubCategory,
                            value: pr.instance.subCategory.name ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.claimType,
                            value: pr.instance.type.name ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.availableTime,
                            value:
                                "${pr.instance.availableDate.toString() ?? S.current.na} - ${widget.claimsDataBean?.availableTime ?? S.current.na}",
                          ),
                          ItemWidget(
                            title: S.current.createdAt,
                            value: Utils.formatDate(pr.instance.createdAt),
                            valueColor: MColors.primary_light_color,
                          ),
                          DescriptionWidget(value: pr.instance.description),
                          FilesWidget(
                            apiStrings: pr.instance.files,
                            count: pr.instance.files.length,
                          ),
                          CommentsWidget(
                            commentsData: pr.instance.comments,
                            presenter: mPresenter,
                            claimId: widget.claimsDataBean.referenceId,
                          ),
                          Visibility(
                            visible: pr.instance.status.toLowerCase() != "closed" &&
                                pr.instance.status != "مغلق" &&
                                pr.instance.status.toLowerCase() != "cancelled" &&
                                pr.instance.status != "ملغي",
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Form(
                                            key: pr.formKey,
                                            child: Container(
                                              width: double.maxFinite,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      S.of(context).addComment,
                                                      style: MTextStyles.textMain14,
                                                    ),
                                                    Gaps.vGap8,
                                                    Gaps.vGap8,
                                                    Gaps.vGap8,
                                                    BuildCommentField(
                                                      provider: provider,
                                                    ),
                                                    Gaps.vGap8,Gaps.vGap8,
                                                    BuildUploadFileField(
                                                      provider: provider,
                                                    ),
                                                    Gaps.vGap8,
                                                    Gaps.vGap8,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            if (provider.formKey.currentState.validate()) {
                                                              if (pr.comment.text.isEmpty) {
                                                                showToasts(
                                                                    S.of(context).enterYourNotesInCommentField, 'warning');
                                                              } else {
                                                                final formData = FormData();
                                                                if (pr.imageFiles != null) {
                                                                  for (var i = 0; i < pr.imageFiles.length; i++) {
                                                                    final file = await pr.imageFiles[i].readAsBytes();
                                                                    formData.files.add(MapEntry(
                                                                      'file[$i]',
                                                                      MultipartFile.fromBytes(file, filename: 'image$i.jpg'),
                                                                    ));
                                                                    formData.fields.add(MapEntry("comment", pr.comment.text));
                                                                    formData.fields.add(MapEntry(
                                                                        "claim_id", widget.claimsDataBean.id.toString()));
                                                                  }
                                                                  mPresenter.doPostCommentApiCall(
                                                                      formData, widget.claimsDataBean.referenceId);
                                                                } else if (pr.file != null) {
                                                                  FormData formData = new FormData.fromMap({
                                                                    "file[0]": await MultipartFile.fromFile(
                                                                      pr.file.path,
                                                                      contentType: new MediaType('application', 'octet-stream'),
                                                                    ),
                                                                    "comment": pr.comment.text,
                                                                    "claim_id": widget.claimsDataBean.id,
                                                                  });
                                                                  mPresenter.doPostCommentApiCall(
                                                                      formData, widget.claimsDataBean.referenceId);
                                                                } else {
                                                                  FormData formData = FormData();
                                                                  formData = new FormData.fromMap({
                                                                    "comment": pr.comment.text,
                                                                    "claim_id": widget.claimsDataBean.id,
                                                                  });
                                                                  mPresenter.doPostCommentApiCall(
                                                                      formData, widget.claimsDataBean.referenceId);
                                                                }
                                                                pr.imageFiles = null;
                                                                pr.file = null;
                                                                pr.comment.clear();
                                                                setState(() {});
                                                              }
                                                            }
                                                          },
                                                          child: Text(
                                                            S.of(context).confirm,
                                                            style:
                                                                MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<Color>(MColors.primary_light_color),
                                                              elevation: MaterialStatePropertyAll(0),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              )),
                                                              padding: MaterialStateProperty.all<EdgeInsets>(
                                                                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                                                        ),
                                                        Gaps.hGap8,
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            pr.comment.clear();
                                                            pr.file = null;
                                                            pr.imageFiles = null;
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            S.of(context).cancel,
                                                            style:
                                                            MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                              MaterialStateProperty.all<Color>(MColors.primary_color),
                                                              elevation: MaterialStatePropertyAll(0),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  )),
                                                              padding: MaterialStateProperty.all<EdgeInsets>(
                                                                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        ImageUtils.getSVGPath("refresh"),
                                      ),
                                      Gaps.hGap8,
                                      Text(
                                        S.of(context).update,
                                        style: MTextStyles.textMain14,
                                      )
                                    ],
                                  ),
                                ),
                                Gaps.hGap12,
                                Gaps.hGap12,
                                /*InkWell(
                                  onTap: () {
                                    mPresenter.deleteClaimApiCall(pr.instance.id);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: MColors.primary_color.withOpacity(0.08), shape: BoxShape.circle),
                                        padding: EdgeInsets.all(4),
                                        child: SvgPicture.asset(
                                          ImageUtils.getSVGPath("trash"),
                                          color: MColors.primary_color,
                                        ),
                                      ),
                                      Gaps.hGap8,
                                      Text(
                                        S.of(context).deleteClaim,
                                        style: MTextStyles.textMain14,
                                      )
                                    ],
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          Gaps.vGap12,
                          Gaps.vGap12,
                          Visibility(
                            visible: pr.instance.status.toLowerCase() != "closed" &&
                                pr.instance.status != "مغلق" &&
                                pr.instance.status.toLowerCase() != "cancelled" &&
                                pr.instance.status != "ملغي",
                            child: InkWell(
                              onTap: () {
                                mPresenter.closeClaimApiCall(pr.instance.referenceId);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: MColors.primary_color.withOpacity(0.08), shape: BoxShape.circle),
                                    padding: EdgeInsets.all(4),
                                    child: SvgPicture.asset(
                                      ImageUtils.getSVGPath("trash"),
                                      color: MColors.primary_color,
                                    ),
                                  ),
                                  Gaps.hGap8,
                                  Text(
                                    S.of(context).closeClaim,
                                    style: MTextStyles.textMain14,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            : Center(child: SizedBox.shrink()),
      );
    });
  }

  @override
  ClaimsDetailsPresenter createPresenter() {
    return ClaimsDetailsPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
