import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/all_claims.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/build_date_picker.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/build_description_field.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/build_drop_time.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/build_file_picker.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/building_grid.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/categories_grid.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/claim_type_grid.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/subcategory_grid.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/units_grid.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/image_utils.dart';
import '../../CommonUtils/model_eventbus/EventBusUtils.dart';
import '../../CommonUtils/model_eventbus/ReloadHomeEevet.dart';
import '../../app_widgets/app_headline.dart';
import '../../app_widgets/custom_stepper.dart' as appStepper;
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/setting.dart';
import '../../res/styles.dart';
import 'ClaimsPresenter.dart';

class ClaimsScreen extends StatefulWidget {
  static const String TAG = "/ClaimsScreen";

  const ClaimsScreen({Key key, this.isFilteredFromHome}) : super(key: key);
  final bool isFilteredFromHome;

  @override
  State<ClaimsScreen> createState() => ClaimsScreenState();
}

class ClaimsScreenState extends BaseState<ClaimsScreen, ClaimsPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final DateFormat _dateFormatEN = DateFormat('yyyy-MM-dd', 'en');
  final DateFormat _dateFormatAR = DateFormat('yyyy-MM-dd', 'ar');

  int selectedBuildingId;
  int selectedUnitId;
  int selectedCategoryId;
  int selectedSubCategoryId;
  int selectedTypeId;

  ClaimsProvider provider;

  final searchController = TextEditingController();

  @override
  void initState() {
    provider = context.read<ClaimsProvider>();
    EventBusUtils.getInstance().on<ReloadEvent>().listen((event) {
      if (event.isRefresh != null || event.isLangChanged != null) {
        Map<String, dynamic> params = Map();
        params['per_page'] = 1000;
        params['page'] = 1;
        params['search'] = provider.searchController.text.toString();
        mPresenter.getAllClaimsApiCall(params);
      }
      setState(() {});
    });
    Map<String, dynamic> params = Map();
    params['per_page'] = 1000;
    params['page'] = 1;
    params['search'] = provider.searchController.text.toString();
    mPresenter.getAllClaimsApiCall(params);
    mPresenter.getBuildingsApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<String> cardTitles = [
      S.current.addNewClaim,
      S.current.allClaims,
    ];
    List<String> cardImages = [
      'newclaims',
      'allclaims',
    ];

    return Scaffold(
      backgroundColor: MColors.page_background,
      body: Consumer<ClaimsProvider>(
        builder: (context, pr, child) => Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 60, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(color: MColors.whiteE, borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    AppHeadline(title: S.of(context).claimManagement),
                    Gaps.vGap16,
                    Container(
                      alignment: Alignment.center,
                      height: 110,
                      child: ListView.builder(
                        shrinkWrap: true,
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
                              child: FittedBox(
                                child: SizedBox(
                                  width: 30.w,
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        ImageUtils.getSVGPath(cardImages[pageIndex]),
                                        color: pr.selectedIndex == pageIndex ? Colors.white : MColors.primary_color,
                                      ),
                                      FittedBox(
                                        child: SizedBox(
                                          width: pr.selectedIndex == pageIndex ? 90 : 100,
                                          child: Text(
                                            cardTitles[pageIndex],
                                            style: MTextStyles.textMainLight14.copyWith(
                                                color: pr.selectedIndex == pageIndex
                                                    ? Colors.white
                                                    : MColors.light_text_color,
                                                fontSize: 9.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Gaps.vGap12,
              Visibility(
                visible: pr.selectedIndex != 0,
                child: Container(
                  decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // width: 237,
                          height: 10.w,
                          child: TextFormField(
                            style: MTextStyles.textDark14,
                            controller: pr.searchController,
                            decoration: InputDecoration(
                              hintText: S.current.search,
                              hintStyle: MTextStyles.textGray14,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: Color(0xffF7F7F7),
                              prefixIcon: GestureDetector(
                                child: Icon(
                                  CupertinoIcons.search,
                                  color: MColors.primary_light_color,
                                ),
                                onTap: () {
                                  // Map<String, dynamic> params = Map();
                                  // params['page'] = 1;
                                  // params['search'] = pr.searchController.text.toString();
                                  // mPresenter.getFilteredClaimsApiCall(params);
                                  print("################## search : ${pr.searchController.text.toString()}");
                                  pr.currentPage = 1;
                                  Map<String, dynamic> params = Map();
                                  params['page'] = pr.currentPage;
                                  params['per_page'] = 1000;
                                  params['search'] = pr.searchController.text.toString();
                                  mPresenter.getAllClaimsApiCall(params);
                                },
                              ),
                              suffixIcon: GestureDetector(
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: MColors.primary_light_color,
                                ),
                                onTap: () {
                                  pr.searchController.clear();
                                  pr.currentPage = 1;
                                  Map<String, dynamic> params = Map();
                                  params['per_page'] = 1000;
                                  params['page'] = 1;
                                  params['search'] = pr.searchController.text.toString();
                                  mPresenter.getAllClaimsApiCall(params);
                                },
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              // Map<String, dynamic> params = Map();
                              // params['page'] = pr.currentPage;
                              // params['search'] = pr.searchController.text.toString();
                              // mPresenter.getFilteredClaimsApiCall(params);
                              pr.currentPage = 1;
                              Map<String, dynamic> params = Map();
                              params['page'] = pr.currentPage;
                              params['per_page'] = 1000;
                              params['search'] = pr.searchController.text.toString();
                              mPresenter.getAllClaimsApiCall(params);
                            },
                            onChanged: (value) {
                              pr.searchValue = value;
                            },
                          ),
                        ),
                      ),
                      // SizedBox(width: 17.0),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Container(
                      //     width: 36,
                      //     height: 36,
                      //     padding: EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(8),
                      //         color: MColors.whiteE,
                      //         boxShadow: [
                      //           BoxShadow(
                      //               color: MColors.coolGrey.withOpacity(0.2),
                      //               spreadRadius: 1,
                      //               blurRadius: 5,
                      //               offset: Offset(1, 4))
                      //         ]),
                      //     child: SvgPicture.asset(ImageUtils.getSVGPath("filter")),
                      //   ),
                      // ),
                      // Gaps.hGap8,
                      // InkWell(
                      //   onTap: () {},
                      //   child: Container(
                      //     width: 36,
                      //     height: 36,
                      //     padding: EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(8),
                      //       color: Color(0xffF7F7F7),
                      //     ),
                      //     child: SvgPicture.asset(ImageUtils.getSVGPath("export")),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: pr.selectedIndex == 0
                    ? pr.isStepsFinished
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 4.w),
                            margin: EdgeInsets.symmetric(vertical: 2.w),
                            decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                            child: ListView(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(S.of(context).newClaimsDetails, style: MTextStyles.textMain18),
                                  ],
                                ),
                                Gaps.vGap12,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.of(context).yourBuilding,
                                        style: MTextStyles.textMain16.copyWith(
                                          color: MColors.black,
                                        )),
                                    Gaps.vGap8,
                                    Text(pr.selectedBuilding ?? "",
                                        style: MTextStyles.textMain14.copyWith(
                                          color: MColors.black,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ],
                                ),
                                Gaps.vGap12,
                                Gaps.vGap12,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.of(context).yourUnit,
                                        style: MTextStyles.textMain16.copyWith(
                                          color: MColors.black,
                                        )),
                                    Gaps.vGap8,
                                    Text(pr.selectedUnit ?? "",
                                        style: MTextStyles.textMain14.copyWith(
                                          color: MColors.black,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ],
                                ),
                                Gaps.vGap12,
                                Gaps.vGap12,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.of(context).claimCategory,
                                        style: MTextStyles.textMain16.copyWith(
                                          color: MColors.black,
                                        )),
                                    Gaps.vGap8,
                                    Text(pr.selectedCategory ?? "",
                                        style: MTextStyles.textMain14.copyWith(
                                          color: MColors.black,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ],
                                ),
                                Gaps.vGap12,
                                Gaps.vGap12,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.of(context).claimSubCategory,
                                        style: MTextStyles.textMain16.copyWith(
                                          color: MColors.black,
                                        )),
                                    Gaps.vGap8,
                                    Text(pr.selectedSubCategory ?? "",
                                        style: MTextStyles.textMain14.copyWith(
                                          color: MColors.black,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ],
                                ),
                                Gaps.vGap12,
                                Gaps.vGap12,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.of(context).claimType,
                                        style: MTextStyles.textMain16.copyWith(
                                          color: MColors.black,
                                        )),
                                    Gaps.vGap8,
                                    Text(pr.selectedType ?? "",
                                        style: MTextStyles.textMain14.copyWith(
                                          color: MColors.black,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ],
                                ),
                                Gaps.vGap12,
                                Gaps.vGap12,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(S.of(context).availableTime,
                                        style: MTextStyles.textMain16.copyWith(
                                          color: MColors.black,
                                        )),
                                    Gaps.vGap8,
                                    Text(
                                        "${pr.selectedDate == null ? DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()) : Setting.mobileLanguage.value == Locale("en") ? _dateFormatEN.format(pr.selectedDate) : _dateFormatAR.format(pr.selectedDate)} ${S.of(context).from} ${pr.selectedTimeValue}",
                                        style: MTextStyles.textMain14.copyWith(
                                          color: MColors.black,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ],
                                ),
                                Visibility(
                                  visible: pr.description.text.isNotEmpty,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(S.of(context).description,
                                            style: MTextStyles.textMain16.copyWith(
                                              color: MColors.black,
                                            )),
                                        Gaps.vGap8,
                                        Text(pr.description.text,
                                            style: MTextStyles.textMain14.copyWith(
                                              color: MColors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Gaps.vGap30,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 30.w,
                                      margin: EdgeInsets.symmetric(vertical: 3.w),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          pr.isStepsFinished = !pr.isStepsFinished;
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
                                      width: 30.w,
                                      margin: EdgeInsets.symmetric(vertical: 3.w),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final formData = FormData();
                                          if (pr.imageFiles != null) {
                                            for (var i = 0; i < pr.imageFiles.length; i++) {
                                              final file = await pr.imageFiles[i].readAsBytes();
                                              formData.files.add(MapEntry(
                                                'file[$i]',
                                                MultipartFile.fromBytes(file, filename: 'image$i.jpg'),
                                              ));
                                              formData.fields.add(MapEntry("unit_id", selectedUnitId.toString()));
                                              formData.fields
                                                  .add(MapEntry("category_id", selectedCategoryId.toString()));
                                              formData.fields
                                                  .add(MapEntry("sub_category_id", selectedSubCategoryId.toString()));
                                              formData.fields.add(MapEntry("claim_type_id", selectedTypeId.toString()));
                                              formData.fields.add(MapEntry("description", provider.description.text));
                                              formData.fields.add(MapEntry(
                                                "available_date",
                                                provider.selectedDate != null
                                                    ? DateFormat('yyyy-MM-dd', 'en').format(provider.selectedDate)
                                                    : DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
                                              ));
                                              formData.fields
                                                  .add(MapEntry("available_time", provider.selectedTimeValue));
                                            }
                                            mPresenter.postClaimRequestApiCall(formData);
                                          } else if (pr.file != null) {
                                            FormData formData = new FormData.fromMap({
                                              "file[0]": await MultipartFile.fromFile(
                                                pr.file.path,
                                                filename: pr.file.path.split('/').last,
                                                contentType: MediaType('application', 'octet-stream'),
                                              ),
                                              "unit_id": selectedUnitId,
                                              "category_id": selectedCategoryId,
                                              "sub_category_id": selectedSubCategoryId,
                                              "claim_type_id": selectedTypeId,
                                              "description": provider.description.text,
                                              "available_date": provider.selectedDate != null
                                                  ? DateFormat('yyyy-MM-dd', 'en').format(provider.selectedDate)
                                                  : DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
                                              "available_time": provider.selectedTimeValue
                                            });
                                            mPresenter.postClaimRequestApiCall(formData);
                                          } else {
                                            Map<String, dynamic> parms = Map();
                                            parms['unit_id'] = selectedUnitId;
                                            parms['category_id'] = selectedCategoryId;
                                            parms['sub_category_id'] = selectedSubCategoryId;
                                            parms['claim_type_id'] = selectedTypeId;
                                            parms['description'] = provider.description.text;
                                            parms['available_date'] = provider.selectedDate != null
                                                ? DateFormat('yyyy-MM-dd', 'en').format(provider.selectedDate)
                                                : DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
                                            parms['available_time'] = provider.selectedTimeValue;
                                            mPresenter.postClaimRequestApiCall(parms);
                                          }
                                        },
                                        child: Text(
                                          S.of(context).confirm,
                                          style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
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
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            margin: EdgeInsets.symmetric(vertical: 2.w),
                            decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 20),
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: pr.currentStep != 0,
                                        child: InkWell(
                                            onTap: () {
                                              pr.currentStep > 0 ? --pr.currentStep : null;
                                            },
                                            child: Setting.mobileLanguage.value != Locale("en")
                                                ? RotatedBox(
                                                    quarterTurns: 2,
                                                    child: SvgPicture.asset(
                                                      ImageUtils.getSVGPath("back_icon"),
                                                      width: 30,
                                                    ),
                                                  )
                                                : SvgPicture.asset(
                                                    ImageUtils.getSVGPath("back_icon"),
                                                    width: 30,
                                                  )),
                                      ),
                                      Expanded(
                                          child: Center(
                                              child: Text(S.of(context).addNewClaim, style: MTextStyles.textMain18))),
                                    ],
                                  ),
                                ),
                                Gaps.vGap12,
                                Expanded(
                                  child: Theme(
                                    data: ThemeData(
                                        canvasColor: Colors.white,
                                        colorScheme:
                                            ColorScheme.light(primary: MColors.primary_color, secondary: Colors.teal)),
                                    child: appStepper.Stepper(
                                        elevation: 0,
                                        type: appStepper.StepperType.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        currentStep: pr.currentStep,
                                        controlsBuilder: (context, details) {
                                          return pr.currentStep != 5
                                              ? SizedBox.shrink()
                                              : Container(
                                                  width: 30.w,
                                                  margin: EdgeInsets.symmetric(vertical: 3.w),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (!pr.formKey.currentState.validate()) {
                                                        return;
                                                      }
                                                      if (pr.selectedDate == null && pr.selectedTimeValue == null) {
                                                        showToasts(S.of(context).youShouldSelectDateAndTime, "warning");
                                                      } else {
                                                        pr.isStepsFinished = !pr.isStepsFinished;
                                                        // mPresenter.postClaimRequestApiCall();
                                                      }
                                                    },
                                                    child: Text(
                                                      S.of(context).confirm,
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
                                                  ),
                                                );
                                        },
                                        onStepTapped: (step) {
                                          pr.currentStep = step;
                                        },
                                        onStepContinue: () {
                                          pr.currentStep < 2 ? pr.currentStep += 1 : null;
                                        },
                                        onStepCancel: () {
                                          pr.currentStep > 0 ? pr.currentStep -= 1 : null;
                                        },
                                        steps: [
                                          appStepper.Step(
                                            title: new Text(''),
                                            content: BuildingGrid(
                                                presenter: mPresenter,
                                                onSelected: (id) {
                                                  selectedBuildingId = id;
                                                  mPresenter.getUnitsApiCall(id);
                                                }),
                                            isActive: pr.currentStep == 0,
                                            state: pr.currentStep == 0
                                                ? appStepper.StepState.indexed
                                                : pr.currentStep > 0
                                                    ? appStepper.StepState.complete
                                                    : appStepper.StepState.disabled,
                                          ),
                                          appStepper.Step(
                                            title: new Text(''),
                                            content: UnitsGrid(
                                                id: selectedUnitId,
                                                presenter: mPresenter,
                                                onSelected: (id) {
                                                  selectedUnitId = id;
                                                  mPresenter.getCategoryApiCall(id);
                                                }),
                                            isActive: pr.currentStep == 1,
                                            state: pr.currentStep == 1
                                                ? appStepper.StepState.indexed
                                                : pr.currentStep > 1
                                                    ? appStepper.StepState.complete
                                                    : appStepper.StepState.disabled,
                                          ),
                                          appStepper.Step(
                                            title: new Text(''),
                                            content: CategoriesGrid(
                                                presenter: mPresenter,
                                                id: selectedCategoryId,
                                                onSelected: (index) {
                                                  selectedCategoryId = pr.categoriesList[index].id;
                                                  pr.subCategoryList = pr.categoriesList[index].subCategory.data;
                                                }),
                                            isActive: pr.currentStep == 2,
                                            state: pr.currentStep == 2
                                                ? appStepper.StepState.indexed
                                                : pr.currentStep > 2
                                                    ? appStepper.StepState.complete
                                                    : appStepper.StepState.disabled,
                                          ),
                                          appStepper.Step(
                                            title: new Text(''),
                                            content: SubcategoryGrid(
                                              onSelected: (id) {
                                                selectedSubCategoryId = id;
                                                mPresenter.getClaimTypeApiCall(id);
                                              },
                                            ),
                                            isActive: pr.currentStep == 3,
                                            state: pr.currentStep == 3
                                                ? appStepper.StepState.indexed
                                                : pr.currentStep > 3
                                                    ? appStepper.StepState.complete
                                                    : appStepper.StepState.disabled,
                                          ),
                                          appStepper.Step(
                                            title: new Text(''),
                                            content: ClaimTypeGrid(
                                                presenter: mPresenter,
                                                id: selectedTypeId,
                                                onSelected: (id) {
                                                  selectedTypeId = id;
                                                  mPresenter.getClaimAvailableTimeApiCall();
                                                }),
                                            isActive: pr.currentStep == 4,
                                            state: pr.currentStep == 4
                                                ? appStepper.StepState.indexed
                                                : pr.currentStep > 4
                                                    ? appStepper.StepState.complete
                                                    : appStepper.StepState.disabled,
                                          ),
                                          appStepper.Step(
                                            title: new Text(''),
                                            content: Form(
                                              key: pr.formKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AppHeadline(title: S.of(context).selectAvailableTime),
                                                  Gaps.vGap10,
                                                  Gaps.vGap12,
                                                  BuildDatePicker(
                                                    provider: pr,
                                                  ),
                                                  Gaps.vGap8,
                                                  BuildTimeDropDown(),
                                                  Gaps.vGap8,
                                                  BuildDescriptionField(
                                                    provider: pr,
                                                  ),
                                                  Gaps.vGap8,
                                                  BuildFilePicker(
                                                    provider: pr,
                                                  )
                                                ],
                                              ),
                                            ),
                                            isActive: pr.currentStep == 5,
                                            state: pr.currentStep == 5
                                                ? appStepper.StepState.indexed
                                                : pr.currentStep > 5
                                                    ? appStepper.StepState.complete
                                                    : appStepper.StepState.disabled,
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          )
                    : AllClaims(
                        presenter: mPresenter,
                        provider: pr,
                      ),
              )
            ],
          ),
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
    return ClaimsPresenter();
  }

  @override
  bool get wantKeepAlive => false;
}
