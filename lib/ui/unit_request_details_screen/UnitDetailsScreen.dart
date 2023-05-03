import 'dart:io';

import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/network/models/UnitRequestResponse.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/build_comment_field.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/build_upload_file_field.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/comments_widget.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/description_widget.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/files_widgets.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/widgets/item_widget.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
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
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              S.of(context).addComment,
                                              style: MTextStyles.textMain14,
                                            ),
                                            Gaps.vGap8,
                                            Gaps.vGap8,
                                            BuildCommentField(
                                              provider: provider,
                                            ),
                                            Gaps.vGap8,
                                            BuildUploadFileField(
                                              provider: provider,
                                            ),
                                            Gaps.vGap8,
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (pr.file != null) {
                                                  // List<File> files;
                                                  FormData formData = FormData();
                                                  // for (int i = 0; i < files?.length; i++) {
                                                  //   formData.files.add(MapEntry(
                                                  //     "file[$i]",
                                                  //     await MultipartFile.fromFile(files[i].path),
                                                  //   ));
                                                  // }
                                                  // formData.fields.add(MapEntry("comment", pr.comment.text));
                                                  // formData.fields.add(MapEntry("claim_id", widget.unitRequestDataBean.id.toString()));
                                                  formData = new FormData.fromMap({
                                                    "file[0]": await MultipartFile.fromFile(
                                                      pr.file.path,
                                                      contentType: new MediaType('image', 'jpg'),
                                                    ),
                                                    "comment": pr.comment.text,
                                                    "claim_id": widget.unitRequestDataBean.id,
                                                  });
                                                  mPresenter.doPostCommentApiCall(
                                                      formData, widget.unitRequestDataBean.id);
                                                }
                                              },
                                              child: Text(
                                                S.of(context).addComment,
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
                              InkWell(
                                onTap: () {
                                  print("@#@#@#@#@#@#@#@#@#@#@# ${pr.instance.id}");
                                  mPresenter.unlinkUnitRequestApiCall({"id":pr.instance.id});
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: MColors.primary_color.withOpacity(0.08), shape: BoxShape.circle),
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.link_off,color: MColors.primary_color)
                                    ),
                                    Gaps.hGap8,
                                    Text(
                                      S.of(context).unlinkUnit,
                                      style: MTextStyles.textMain14,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Gaps.vGap12,
                          Gaps.vGap12,
                          // InkWell(
                          //   onTap: () {
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) {
                          //         return AlertDialog(
                          //           content: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Text(
                          //                 S.of(context).renew,
                          //                 style: MTextStyles.textMain14,
                          //               ),
                          //               Gaps.vGap8,
                          //               Gaps.vGap8,
                          //               Container(
                          //                 height: MediaQuery.of(context).size.height * .06,
                          //                 child: TextFormField(
                          //                   controller: pr.contractNo,
                          //                   style: MTextStyles.textDark14,
                          //                   decoration: InputDecoration(
                          //                     hintText: S.of(context).contractNo,
                          //                     hintStyle: MTextStyles.textMain14.copyWith(color: MColors.light_text_color, fontWeight: FontWeight.w500),
                          //                     border: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                     enabledBorder: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                     focusedBorder: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               Gaps.vGap8,
                          //               GestureDetector(
                          //                 onTap: () async{
                          //                   final DateTime picked = await showDatePicker(
                          //                         context: context,
                          //                         initialDate: pr.endDate ?? DateTime.now(),
                          //                         firstDate: DateTime(1900),
                          //                         lastDate: DateTime.now().add(Duration(days: 1000)));
                          //                     if (picked != null) {
                          //                       pr.endDate = picked;
                          //                     }
                          //                 },
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                     borderRadius: BorderRadius.circular(8),
                          //                     border: Border.all(color: MColors.textFieldBorder),
                          //                   ),
                          //                   padding: EdgeInsets.all(10.0),
                          //                   child: Row(
                          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       Text(
                          //                         pr.endDate != null
                          //                             ? _dateFormatEN.format(pr.endDate)
                          //                             : S.of(context).endDate,
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ),
                          //               Gaps.vGap8,
                          //               TextFormField(
                          //                 style: MTextStyles.textDark14,
                          //                 readOnly: true,
                          //                 controller: TextEditingController(text: pr?.contractImg?.path),
                          //                 // initialValue: pr.contractImg.path,
                          //                 decoration: InputDecoration(
                          //                     hintText: S.of(context).uploadContractImage,
                          //                     hintStyle: MTextStyles.textMain14,
                          //                     border: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                     enabledBorder: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                     focusedBorder: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                     suffixIcon:  InkWell(
                          //                       onTap: () async {
                          //                         pr.updateContractImg(null);
                          //                       },
                          //                       child:Padding(
                          //                         padding: const EdgeInsets.all(12.0),
                          //                         child: Icon(Icons.close),
                          //                       ),
                          //                     ),
                          //                     prefixIcon: InkWell(
                          //                       onTap: () async {
                          //                         final result = await FilePicker.platform.pickFiles();
                          //                         if (result != null) {
                          //                           final file = File(result.files.single.path);
                          //                           pr.updateContractImg(file);
                          //                         }
                          //                         // FilePickerResult result = await FilePicker.platform.pickFiles();
                          //                         // if (result != null) {
                          //                         //   File file = File(result.files.single.path);
                          //                         //   pr.contractImg.absolute.path = path.basename(file.path);
                          //                         // }
                          //                       },
                          //                       child:Padding(
                          //                         padding: const EdgeInsets.all(12.0),
                          //                         child: SvgPicture.asset(ImageUtils.getSVGPath("file_upload")),
                          //                       ),
                          //                     )),
                          //
                          //               ),
                          //               Gaps.vGap8,
                          //               TextFormField(
                          //                 controller: TextEditingController(text: pr?.identityImg?.path),
                          //                 style: MTextStyles.textDark14,
                          //                 readOnly: true,
                          //                 decoration: InputDecoration(
                          //                     hintText: S.of(context).uploadIdentityImage,
                          //                     hintStyle: MTextStyles.textMain14,
                          //                     border: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                     enabledBorder: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                     focusedBorder: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(8),
                          //                       borderSide: BorderSide(color: MColors.textFieldBorder),
                          //                     ),
                          //                     suffixIcon:  InkWell(
                          //                       onTap: () async {
                          //                         pr.updateIdentityImg(null);
                          //                       },
                          //                       child:Padding(
                          //                         padding: const EdgeInsets.all(12.0),
                          //                         child: Icon(Icons.close),
                          //                       ),
                          //                     ),
                          //                     prefixIcon: InkWell(
                          //                       onTap: () async {
                          //                         final result = await FilePicker.platform.pickFiles();
                          //                         if (result != null) {
                          //                           final file = File(result.files.single.path);
                          //                           pr.updateIdentityImg(file);
                          //                         }
                          //                       },
                          //                       child:Padding(
                          //                         padding: const EdgeInsets.all(12.0),
                          //                         child: SvgPicture.asset(ImageUtils.getSVGPath("file_upload")),
                          //                       ),
                          //                     )),
                          //
                          //               ),
                          //               Gaps.vGap8, Gaps.vGap8,
                          //               ElevatedButton(
                          //                 onPressed:  () async {
                          //                   if (pr.contractNo.text.isEmpty && pr.endDate == null) {
                          //                     mPresenter.view.showSnackBar("msg");
                          //                   } else {
                          //                     FormData formData = new FormData.fromMap({
                          //                       "contract_attach": await MultipartFile.fromFile(
                          //                         pr.contractImg.path,
                          //                         filename: pr.contractImg.path.split('/').last,
                          //                         contentType: MediaType('application', 'octet-stream'),
                          //                       ),
                          //                       "client_gov_id": await MultipartFile.fromFile(
                          //                         pr.identityImg.path,
                          //                         filename: pr.identityImg.path.split('/').last,
                          //                         contentType: MediaType('application', 'octet-stream'),
                          //                       ),
                          //                       "contract_no": pr.contractNo.text,
                          //                       "end_at": pr.endDate.toString(),
                          //                       "id": pr.instance.id,
                          //                     });
                          //                     mPresenter.renewUnitLinkRequestApiCall(formData);
                          //                   }
                          //                 },
                          //                 child: Text(
                          //                   S.of(context).renew,
                          //                   style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                          //                 ),
                          //                 style: ButtonStyle(
                          //                     backgroundColor:
                          //                     MaterialStateProperty.all<Color>(MColors.primary_color),
                          //                     elevation: MaterialStatePropertyAll(0),
                          //                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          //                         RoundedRectangleBorder(
                          //                           borderRadius: BorderRadius.circular(8),
                          //                         )),
                          //                     padding: MaterialStateProperty.all<EdgeInsets>(
                          //                         EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                          //               )
                          //             ],
                          //           ),
                          //         );
                          //       },
                          //     );
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         decoration: BoxDecoration(
                          //             color: MColors.primary_color.withOpacity(0.08), shape: BoxShape.circle),
                          //         padding: EdgeInsets.all(4),
                          //         child: Icon(Icons.update,color: MColors.primary_color)
                          //       ),
                          //       Gaps.hGap8,
                          //       Text(
                          //         S.of(context).renew,
                          //         style: MTextStyles.textMain14,
                          //       )
                          //     ],
                          //   ),
                          // ),
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
  UnitDetailsPresenter createPresenter() {
    return UnitDetailsPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
