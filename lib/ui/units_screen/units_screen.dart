import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:Cliamizer/ui/units_screen/widgets/build_description_field.dart';
import 'package:Cliamizer/ui/units_screen/widgets/build_file_picker.dart';
import 'package:Cliamizer/ui/units_screen/widgets/build_qrcode_field.dart';
import 'package:Cliamizer/ui/units_screen/widgets/build_start_end_date_picker_fields.dart';
import 'package:Cliamizer/ui/units_screen/widgets/building_name_field.dart';
import 'package:Cliamizer/ui/units_screen/widgets/company_name_field.dart';
import 'package:Cliamizer/ui/units_screen/widgets/contract_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../CommonUtils/image_utils.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import 'units_presenter.dart';

class UnitsScreen extends StatefulWidget {
  static const String TAG = "/UnitsScreen";

  const UnitsScreen({Key key}) : super(key: key);

  @override
  State<UnitsScreen> createState() => UnitsScreenState();
}

class UnitsScreenState extends BaseState<UnitsScreen, UnitPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  UnitProvider provider = UnitProvider();
  List<String> cardTitles = [
    S.current.newLinkRequest,
    S.current.existingUnit,
    S.current.unitLinkRequest,
  ];
  List<String> cardImages = [
    'new_unit_link',
    'existing_unit',
    'unit_link_request',
  ];
  List<String> _unitItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String selectedBuilding;
  String selectedUnit;
  String selectedCategory;
  String selectedSubCategory;
  String selectedType;

  @override
  void initState() {
    // mPresenter.getAllClaimsApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: MColors.page_background,
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 60, 16, 0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 1.w,
                        height: 5.w,
                        margin: EdgeInsetsDirectional.only(end: 2.w),
                        decoration: BoxDecoration(color: MColors.primary_color, borderRadius: BorderRadius.circular(4)),
                      ),
                      Text(S.of(context).unitsProperty, style: MTextStyles.textMain18),
                    ],
                  ),
                  Gaps.vGap16,
                  Consumer<UnitProvider>(
                    builder: (context, pr, child) => Container(
                      height: 12.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardTitles.length,
                        itemBuilder: (context, pageIndex) {
                          return GestureDetector(
                            onTap: () {
                              pr.selectedIndex = pageIndex;
                            },
                            child: Card(
                              elevation: 0.5,
                              color: pr.selectedIndex == pageIndex ? MColors.primary_color : Colors.white,
                              child: SizedBox(
                                width: 25.w,
                                height: 96,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      ImageUtils.getSVGPath(cardImages[pageIndex]),
                                      color: pr.selectedIndex == pageIndex ? Colors.white : MColors.primary_color,
                                    ),
                                    SizedBox(
                                      width: pr.selectedIndex == pageIndex ? 70 : 80,
                                      child: Text(
                                        cardTitles[pageIndex],
                                        style: MTextStyles.textMainLight14.copyWith(
                                            color:
                                                pr.selectedIndex == pageIndex ? Colors.white : MColors.light_text_color,
                                            fontSize: pr.selectedIndex == pageIndex ? 14 : 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Gaps.vGap12,
            Container(
              decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
              child: Row(
                children: [
                  Expanded(
                    child: SearchField(),
                  ),
                  SizedBox(width: 17.0),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 36,
                      height: 36,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MColors.whiteE,
                          boxShadow: [
                            BoxShadow(
                                color: MColors.coolGrey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(1, 4))
                          ]),
                      child: SvgPicture.asset(ImageUtils.getSVGPath("filter")),
                    ),
                  ),
                  Gaps.hGap8,
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 36,
                      height: 36,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffF7F7F7),
                      ),
                      child: SvgPicture.asset(ImageUtils.getSVGPath("export")),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<UnitProvider>(
                builder: (context, pr, child) {
                  return PageView(
                    children: [
                      pr.selectedIndex == 0
                          ? !pr.isQrCodeValid
                              ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
                                  margin: EdgeInsets.symmetric(vertical: 2.w),
                                  decoration:
                                      BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                                  child: ListView(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(child: Text(S.current.newLinkRequest, style: MTextStyles.textMain18)),
                                      Gaps.vGap8,
                                      Gaps.vGap8,
                                      Gaps.vGap8,
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 1.w,
                                            height: 5.w,
                                            margin: EdgeInsetsDirectional.only(end: 3.w),
                                            decoration: BoxDecoration(
                                                color: MColors.primary_color, borderRadius: BorderRadius.circular(4)),
                                          ),
                                          Text(S.of(context).unitQuery, style: MTextStyles.textMain16),
                                        ],
                                      ),
                                      Gaps.vGap8,
                                      Gaps.vGap12,
                                      BuildQRCodeField(
                                        provider: provider,
                                      ),
                                      Container(
                                        width: 100.w,
                                        margin: EdgeInsetsDirectional.only(
                                          top: 6.w,
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if(pr.qrCode.text == "12345678"){
                                              pr.isQrCodeValid = !pr.isQrCodeValid;
                                            }else if(pr.qrCode.text =="1234"){
                                              pr.qrCodeValid=true;
                                            }else{
                                              pr.qrCodeValid =false;
                                            }
                                          },
                                          child: Text(
                                            S.of(context).search,
                                            style: MTextStyles.textMain14
                                                .copyWith(fontWeight: FontWeight.w700, color: MColors.white),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
                                              elevation: MaterialStatePropertyAll(0),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              )),
                                              padding: MaterialStateProperty.all<EdgeInsets>(
                                                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                                        ),
                                      ),
                                      Gaps.vGap8,
                                     Visibility(
                                       visible: pr.qrCodeValid == false,
                                       child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Color(0xffDA1414).withOpacity(0.12),
                                              borderRadius: BorderRadius.circular(8)),
                                          child: Text(
                                            S.of(context).theQrCodeIsIncorrect,
                                            style: MTextStyles.textMain14.copyWith(fontSize: 9.sp),
                                          ),
                                        ),
                                     ),
                                      Visibility(
                                        visible:pr.qrCodeValid == true,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Color(0xff44A4F2).withOpacity(0.12),
                                              borderRadius: BorderRadius.circular(8)),
                                          child: Text(
                                            S.of(context).theUnitIsReserved,
                                            style:
                                                MTextStyles.textMain14.copyWith(fontSize: 9.sp, color: Color(0xff44A4F2)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 4.w),
                                  margin: EdgeInsets.symmetric(vertical: 2.w),
                                  decoration:
                                      BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                                  child: ListView(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(S.current.newLinkRequest, style: MTextStyles.textMain18),
                                        ],
                                      ),
                                      Gaps.vGap8,
                                      Gaps.vGap8,
                                      Gaps.vGap8,
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 1.w,
                                            height: 5.w,
                                            margin: EdgeInsetsDirectional.only(end: 3.w),
                                            decoration: BoxDecoration(
                                                color: MColors.primary_color, borderRadius: BorderRadius.circular(4)),
                                          ),
                                          Text(S.current.unitQuery, style: MTextStyles.textMain16),
                                        ],
                                      ),
                                      Gaps.vGap8,
                                      Gaps.vGap12,
                                      BuildingNameField(
                                        provider: provider,
                                      ),
                                      Gaps.vGap8,
                                      CompanyNameField(
                                        provider: provider,
                                      ),
                                      Gaps.vGap8,
                                      ContractField(
                                        provider: provider,
                                      ),
                                      Gaps.vGap8,
                                      StartEndDatePickerField(),
                                      Gaps.vGap8,
                                      BuildFilePicker(provider: provider),
                                      Gaps.vGap8,
                                      BuildDescriptionField(
                                        provider: provider,
                                      ),
                                      Gaps.vGap12,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * .4,
                                            margin: EdgeInsets.symmetric(vertical: 3.w),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                pr.isQrCodeValid = !pr.isQrCodeValid;
                                              },
                                              child: Text(
                                                S.of(context).back,
                                                style: MTextStyles.textMain14.copyWith(fontWeight: FontWeight.w700),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color>(MColors.white),
                                                  elevation: MaterialStatePropertyAll(0),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          side: BorderSide(color: MColors.primary_color))),
                                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * .4,
                                            margin: EdgeInsets.symmetric(vertical: 3.w),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    backgroundColor: MColors.whiteE,
                                                    elevation: 0,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(ImageUtils.getSVGPath("done")),
                                                        Gaps.vGap16,
                                                        Text(S.current.confirmation,
                                                            style: MTextStyles.textMain16.copyWith(
                                                              color: MColors.black,
                                                            )),
                                                        Gaps.vGap8,
                                                        Text(
                                                          S.current.thankYouForSubmittingYourRequestOneOfOurCustomerservices,
                                                          style: MTextStyles.textSubtitle,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        Gaps.vGap30,
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            pr.isQrCodeValid = !pr.isQrCodeValid;
                                                            pr.qrCode.clear();
                                                            pr.contractNo.clear();
                                                            pr.companyName.clear();
                                                            pr.buildingName.clear();
                                                            pr.description.clear();
                                                            pr.fileName = "";
                                                            pr.qrCodeValid = !pr.qrCodeValid;
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            S.of(context).backToHome,
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
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                S.of(context).confirm,
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
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                          : pr.selectedIndex == 1
                              ? ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Container(
                                    decoration:
                                        BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
                                    margin: index == 0 ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 2.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Falcon Tower A5 - Owned",
                                                  style: MTextStyles.textBoldDark16,
                                                ),
                                                Text(
                                                  S.of(context).requestCode + " #123-45-567",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Container(
                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: Color(0xff44A4F2).withOpacity(0.08),
                                                  borderRadius: BorderRadius.circular(32),
                                                ),
                                                child: Text("New" ?? '',
                                                    style: MTextStyles.textDark12.copyWith(
                                                        color: MColors.blueButtonColor, fontWeight: FontWeight.w600)))
                                          ],
                                        ),
                                        buildDivider(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).unitName,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "2023-10-14",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap8,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).unitName,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "Falacon unit",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap8,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).clientId,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "345567890",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap8,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).startAt,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "2023-10-14",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap8,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).endAt,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "2023-10-14",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Container(
                                    decoration:
                                        BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
                                    margin: index == 0 ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 2.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Falcon Tower A5 - Owned",
                                                  style: MTextStyles.textBoldDark16,
                                                ),
                                                Text(
                                                  S.of(context).requestCode + " #123-45-567",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Container(
                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: Color(0xff44A4F2).withOpacity(0.08),
                                                  borderRadius: BorderRadius.circular(32),
                                                ),
                                                child: Text("New" ?? '',
                                                    style: MTextStyles.textDark12.copyWith(
                                                        color: MColors.blueButtonColor, fontWeight: FontWeight.w600)))
                                          ],
                                        ),
                                        buildDivider(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).unitName,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "2023-10-14",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap8,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).unitName,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "Falacon unit",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap8,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).clientId,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "345567890",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap8,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).startAt,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "2023-10-14",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap8,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  S.of(context).endAt,
                                                  style: MTextStyles.textBoldDark12
                                                      .copyWith(color: MColors.subtitlesColor),
                                                ),
                                                Text(
                                                  "2023-10-14",
                                                  style: MTextStyles.textSubtitle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildDivider() {
    return Column(
      children: [
        Gaps.vGap16,
        Divider(
          color: MColors.dividerColor,
        ),
        Gaps.vGap16,
      ],
    );
  }

  @override
  createPresenter() {
    return UnitPresenter();
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 237,
      height: 10.w,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: MTextStyles.textGray14,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: MColors.primary_light_color,
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: Color(0xffF7F7F7),
        ),
      ),
    );
  }
}
