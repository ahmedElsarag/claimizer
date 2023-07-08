import 'dart:io';

import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/network/models/UnitRequestResponse.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/build_comment_field.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/build_renew_notes.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/build_upload_file_field.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/comments_widget.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/item_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../app_widgets/app_headline.dart';
import '../../app_widgets/claimizer_app_bar.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import 'UnitDetailsPresenter.dart';
import 'UnitDetailsProvider.dart';

class UnitRequestDetailsScreen extends StatefulWidget {
  static const String TAG = "/UnitRequestDetailsScreen";
  final int id;
  final UnitRequestDataBean unitRequestDataBean;

  UnitRequestDetailsScreen({
    Key key,
    this.id,
    this.unitRequestDataBean,
  }) : super(key: key);

  @override
  State<UnitRequestDetailsScreen> createState() => UnitRequestDetailsScreenState();
}

class UnitRequestDetailsScreenState extends BaseState<UnitRequestDetailsScreen, UnitDetailsPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  UnitDetailsProvider provider;
  final DateFormat _dateFormatEN = DateFormat('yyyy-MM-dd', 'en');

  @override
  void initState() {
    super.initState();
    provider = context.read<UnitDetailsProvider>();

    mPresenter.getUnitRequestDetailsDataApiCall(widget.unitRequestDataBean.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UnitDetailsProvider>(builder: (context, pr, child) {
      return Scaffold(
        backgroundColor: MColors.page_background,
        body: pr.instance != null
            ? SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                  child: ListView(children: [
                    ClaimizerAppBar(title: S.of(context).unitLinkRequestDetails),
                    Gaps.vGap12,
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 6.w),
                      margin: EdgeInsets.symmetric(vertical: 2.w),
                      decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppHeadline(title: pr.instance?.unitName ?? S.current.na),
                          Gaps.vGap30,
                          ItemWidget(
                            title: S.current.yourBuilding,
                            value: pr.instance?.buildingName ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.yourUnit,
                            value: pr.instance.unitName ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.of(context).unitStatus,
                            value: pr.instance.status ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.unitType,
                            value: pr.instance.unitType ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.startDate,
                            value: pr.instance.startAt ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.endDate,
                            value: pr.instance.endAt ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.current.company,
                            value: pr.instance.company ?? S.current.na,
                          ),
                          ItemWidget(
                            title: S.of(context).userRemarks,
                            value: pr.instance.userRemarks ?? S.current.na,
                          ),
                          CommentsWidget(
                            commentsData: pr.instance.comments,
                            presenter: mPresenter,
                            claimId: widget.unitRequestDataBean.refCode,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
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
                                          Gaps.vGap8,
                                          Gaps.vGap8,
                                          BuildUploadFileField(
                                            provider: provider,
                                            presenter: mPresenter,
                                          ),
                                          Gaps.vGap8,
                                          Gaps.vGap8,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (pr.comment.text.isEmpty) {
                                                    showToasts(S.of(context).enterYourNotesInCommentField, 'warning');
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
                                                            "request_id", widget.unitRequestDataBean.id.toString()));
                                                      }
                                                      mPresenter.doPostCommentApiCall(
                                                          formData, widget.unitRequestDataBean.id);
                                                    } else if (pr.file != null) {
                                                      FormData formData = new FormData.fromMap({
                                                        "file[0]": await MultipartFile.fromFile(
                                                          pr.file.path,
                                                          contentType: new MediaType('application', 'octet-stream'),
                                                        ),
                                                        "comment": pr.comment.text,
                                                        "request_id": widget.unitRequestDataBean.id,
                                                      });
                                                      mPresenter.doPostCommentApiCall(
                                                          formData, widget.unitRequestDataBean.id);
                                                    } else {
                                                      FormData formData = FormData();
                                                      formData = new FormData.fromMap({
                                                        "comment": pr.comment.text,
                                                        "request_id": widget.unitRequestDataBean.id,
                                                      });
                                                      mPresenter.doPostCommentApiCall(
                                                          formData, widget.unitRequestDataBean.id);
                                                    }
                                                    pr.imageFiles = null;
                                                    pr.file = null;
                                                    pr.comment.clear();
                                                    setState(() {});
                                                  }
                                                },
                                                child: Text(
                                                  S.of(context).confirm,
                                                  style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
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
                                                  style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
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
                                          ),
                                        ],
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
                                AutoSizeText(
                                  S.of(context).update,
                                  style: TextStyle(color: MColors.primary_color),
                                )
                              ],
                            ),
                          ),
                          Gaps.vGap12,
                          Gaps.vGap12,
                          pr.instance.status.toLowerCase() != "rejected" &&
                                  pr.instance.status.toLowerCase() != "canceled" &&
                                  pr.instance.status != "مرفوض" &&
                                  pr.instance.status != "ملغي"
                              ? InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Consumer<UnitDetailsProvider>(
                                          builder: (context, pro, child) => AlertDialog(
                                            contentPadding: EdgeInsets.all(16),
                                            content: SingleChildScrollView(
                                              child: Container(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Are you sure to un-link your unit?",
                                                      style: MTextStyles.textDark14,
                                                    ),
                                                    Gaps.vGap8,
                                                    Gaps.vGap8,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            mPresenter.unlinkUnitRequestApiCall(
                                                                {
                                                                  "id": pr.instance.id,
                                                                  "unlink_status":"canceled", // terminated, finished
                                                                  // "comment":"a",
                                                                  "unlink_date":"2023-05-11",
                                                                  "unlink_reason":"ojh"
                                                                });
                                                          },
                                                          child: Text(
                                                            S.of(context).confirm,
                                                            style: MTextStyles.textWhite14
                                                                .copyWith(fontWeight: FontWeight.w700),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                                  MColors.primary_color),
                                                              elevation: MaterialStatePropertyAll(0),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              )),
                                                              padding: MaterialStateProperty.all<EdgeInsets>(
                                                                  EdgeInsets.symmetric(
                                                                      horizontal: 4.w, vertical: 3.w))),
                                                        ),
                                                        Gaps.hGap8,
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            S.of(context).cancel,
                                                            style: MTextStyles.textWhite14
                                                                .copyWith(fontWeight: FontWeight.w700),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                                  MColors.primary_light_color),
                                                              elevation: MaterialStatePropertyAll(0),
                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              )),
                                                              padding: MaterialStateProperty.all<EdgeInsets>(
                                                                  EdgeInsets.symmetric(
                                                                      horizontal: 4.w, vertical: 3.w))),
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
                                      Container(
                                          decoration: BoxDecoration(
                                              color: MColors.primary_color.withOpacity(0.08), shape: BoxShape.circle),
                                          padding: EdgeInsets.all(4),
                                          child: Icon(Icons.link_off, color: MColors.primary_color)),
                                      Gaps.hGap8,
                                      AutoSizeText(
                                        S.of(context).unlinkUnit,
                                        style: TextStyle(color: MColors.primary_color),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                          Gaps.vGap12,
                          Gaps.vGap12,
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Consumer<UnitDetailsProvider>(
                                    builder: (context, pro, child) => AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                S.of(context).renew,
                                                style: MTextStyles.textMain14,
                                              ),
                                              Gaps.vGap8,
                                              Gaps.vGap8,
                                              Gaps.vGap8,
                                              Container(
                                                height: MediaQuery.of(context).size.height * .07,
                                                child: TextFormField(
                                                  controller: pr.contractNo,
                                                  style: MTextStyles.textDark14,
                                                  decoration: InputDecoration(
                                                      hintText: S.of(context).contractNo,
                                                      hintStyle: MTextStyles.textMain14.copyWith(
                                                          color: MColors.light_text_color, fontWeight: FontWeight.w500),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: MColors.textFieldBorder),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: MColors.textFieldBorder),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: MColors.textFieldBorder),
                                                      ),
                                                      labelStyle: MTextStyles.textDark14),
                                                ),
                                              ),
                                              Gaps.vGap8,
                                              Gaps.vGap8,
                                              Container(
                                                height: MediaQuery.of(context).size.height * .07,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    final DateTime picked = await showDatePicker(
                                                        context: context,
                                                        initialDate: pr.endDate ?? DateTime.now(),
                                                        firstDate: DateTime(1900),
                                                        lastDate: DateTime.now().add(Duration(days: 100000)));
                                                    if (picked != null) {
                                                      pr.endDate = picked;
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(color: MColors.textFieldBorder),
                                                    ),
                                                    padding: EdgeInsets.all(12.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          pr.endDate != null
                                                              ? _dateFormatEN.format(pr.endDate)
                                                              : S.of(context).endDate,
                                                          style: MTextStyles.textDark14,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Gaps.vGap8,
                                              Gaps.vGap8,
                                              GestureDetector(
                                                  onTap: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                width: 60.w,
                                                                child: ElevatedButton.icon(
                                                                  onPressed: getContractFromCamera,
                                                                  icon: Icon(Icons.camera_alt,
                                                                      color: MColors.text_button_color),
                                                                  label: FittedBox(
                                                                    child: Text(S.of(context).takePhoto,
                                                                        style: MTextStyles.textMain12.copyWith(
                                                                            color: MColors.text_button_color)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 8),
                                                              Container(
                                                                width: 60.w,
                                                                child: ElevatedButton.icon(
                                                                  onPressed: pickContractFromGallery,
                                                                  icon: Icon(Icons.photo_library,
                                                                      color: MColors.text_button_color),
                                                                  label: FittedBox(
                                                                    child: Text(
                                                                      S.of(context).chooseFromGallery,
                                                                      style: MTextStyles.textMain12
                                                                          .copyWith(color: MColors.text_button_color),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: MColors.textFieldBorder),
                                                        borderRadius: BorderRadius.circular(8)),
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        pr.contractImg != null
                                                            ? ClipRRect(
                                                                borderRadius: BorderRadius.circular(12),
                                                                child: Image.file(
                                                                  pr.contractImg,
                                                                  width: 10.w,
                                                                  height: 10.w,
                                                                  fit: BoxFit.cover,
                                                                ))
                                                            : Column(
                                                                children: [
                                                                  SvgPicture.asset(ImageUtils.getSVGPath("file_upload"),
                                                                      color: MColors.light_text_color),
                                                                  Gaps.vGap8,
                                                                  Text(
                                                                    S.of(context).uploadContractImage,
                                                                    style: MTextStyles.textMain14
                                                                        .copyWith(color: MColors.light_text_color),
                                                                  ),
                                                                ],
                                                              ),
                                                        // Spacer(),
                                                        Visibility(
                                                          visible: pr.contractImg != null,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              pr.contractImg = null;
                                                              setState(() {});
                                                            },
                                                            child: Icon(Icons.close),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              Gaps.vGap8,
                                              Gaps.vGap8,
                                              GestureDetector(
                                                  onTap: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                width: 60.w,
                                                                child: ElevatedButton.icon(
                                                                  onPressed: getIdentityFromCamera,
                                                                  icon: Icon(Icons.camera_alt,
                                                                      color: MColors.text_button_color),
                                                                  label: FittedBox(
                                                                    child: Text(S.of(context).takePhoto,
                                                                        style: MTextStyles.textMain12.copyWith(
                                                                            color: MColors.text_button_color)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 8),
                                                              Container(
                                                                width: 60.w,
                                                                child: ElevatedButton.icon(
                                                                  onPressed: pickIdentityFromGallery,
                                                                  icon: Icon(Icons.photo_library,
                                                                      color: MColors.text_button_color),
                                                                  label: FittedBox(
                                                                    child: Text(
                                                                      S.of(context).chooseFromGallery,
                                                                      style: MTextStyles.textMain12
                                                                          .copyWith(color: MColors.text_button_color),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: MColors.textFieldBorder),
                                                        borderRadius: BorderRadius.circular(8)),
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        pr.identityImg != null
                                                            ? ClipRRect(
                                                                borderRadius: BorderRadius.circular(12),
                                                                child: Image.file(
                                                                  pr.identityImg,
                                                                  width: 10.w,
                                                                  height: 10.w,
                                                                  fit: BoxFit.cover,
                                                                ))
                                                            : Column(
                                                                children: [
                                                                  SvgPicture.asset(ImageUtils.getSVGPath("file_upload"),
                                                                      color: MColors.light_text_color),
                                                                  Gaps.vGap8,
                                                                  Text(
                                                                    S.of(context).uploadIdentityImage,
                                                                    style: MTextStyles.textMain14
                                                                        .copyWith(color: MColors.light_text_color),
                                                                  ),
                                                                ],
                                                              ),
                                                        // Spacer(),
                                                        Visibility(
                                                          visible: pr.identityImg != null,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              pr.identityImg = null;
                                                              setState(() {});
                                                            },
                                                            child: Icon(Icons.close),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              Gaps.vGap8,
                                              Gaps.vGap8,
                                              BuildRenewNotesField(
                                                provider: provider,
                                              ),
                                              Gaps.vGap8,
                                              Gaps.vGap8,
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      if (pr.contractNo.text.isEmpty && pr.endDate == null) {
                                                        showToasts(S.of(context).enterContractNoAndEndDate, 'warning');
                                                      } else if (pr.contractNo.text.isEmpty) {
                                                        showToasts(S.of(context).pleaseEnterContractNumber, 'warning');
                                                      } else if (pr.endDate == null) {
                                                        showToasts(S.of(context).pleaseEnterContractEndDate, 'warning');
                                                      } else {
                                                        FormData formData = new FormData.fromMap({
                                                          "contract_attach": await MultipartFile.fromFile(
                                                            pr.contractImg.path,
                                                            filename: pr.contractImg.path.split('/').last,
                                                            contentType: MediaType('application', 'octet-stream'),
                                                          ),
                                                          "client_gov_id": await MultipartFile.fromFile(
                                                            pr.identityImg.path,
                                                            filename: pr.identityImg.path.split('/').last,
                                                            contentType: MediaType('application', 'octet-stream'),
                                                          ),
                                                          "contract_no": pr.contractNo.text,
                                                          "note": pr.renewNotes.text,
                                                          "end_at": pr.endDate.toString(),
                                                          "id": pr.instance.id,
                                                        });
                                                        mPresenter.renewUnitLinkRequestApiCall(
                                                            formData, widget.unitRequestDataBean.id);
                                                        // Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Text(
                                                      S.of(context).renew,
                                                      style:
                                                          MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                                                    ),
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty.all<Color>(
                                                            MColors.primary_light_color),
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
                                                      pr.contractNo.clear();
                                                      pr.renewNotes.clear();
                                                      pr.endDate = null;
                                                      pr.contractImg = null;
                                                      pr.identityImg = null;
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
                                Container(
                                    decoration: BoxDecoration(
                                        color: MColors.primary_color.withOpacity(0.08), shape: BoxShape.circle),
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.update, color: MColors.primary_color)),
                                Gaps.hGap8,
                                AutoSizeText(
                                  S.of(context).renew,
                                  style: TextStyle(color: MColors.primary_color),
                                )
                              ],
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

  final picker = ImagePicker();

  Future<void> pickContractFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        provider.contractImg = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future getContractFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        provider.contractImg = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MColors.error_color,
            margin: EdgeInsets.all(8),
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).noImageSelected)));
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
    Navigator.pop(context);
  }

  Future<void> pickIdentityFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        provider.identityImg = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future getIdentityFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        provider.identityImg = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MColors.error_color,
            margin: EdgeInsets.all(8),
            behavior: SnackBarBehavior.floating,
            content: Text(S.of(context).noImageSelected)));
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
    Navigator.pop(context);
  }

  @override
  UnitDetailsPresenter createPresenter() {
    return UnitDetailsPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
