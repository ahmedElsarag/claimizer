import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/build_date_picker.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/build_description_field.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/build_drop_time.dart';
import 'package:Cliamizer/ui/claims_screen/widgets/build_file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/image_utils.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
import '../main_screens/MainScreen.dart';
import 'ClaimsPresenter.dart';

class ClaimsScreen extends StatefulWidget {
  static const String TAG = "/ClaimsScreen";

  const ClaimsScreen({Key key}) : super(key: key);

  @override
  State<ClaimsScreen> createState() => ClaimsScreenState();
}

class ClaimsScreenState extends BaseState<ClaimsScreen, ClaimsPresenter> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  ClaimsProvider provider = ClaimsProvider();
  List<String> cardTitles = [
    S.current.newClaims,
    S.current.allClaims,
    S.current.claimsRequests,
  ];
  List<String> cardImages = [
    'newclaims',
    'allclaims',
    'claims_requests',
  ];
  List<String> _unitItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7', 'Item 8', 'Item 9', 'Item 10'];
  String selectedBuilding;
  String selectedUnit;
  String selectedCategory;
  String selectedSubCategory;
  String selectedType;

  @override
  void initState() {
    mPresenter.getAllClaimsApiCall();
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
                      Text(S.of(context).claimManagement, style: MTextStyles.textMain18),
                    ],
                  ),
                  Gaps.vGap16,
                  Consumer<ClaimsProvider>(
                    builder: (context, pr, child) => Container(
                      height: 110,
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
                                            color: pr.selectedIndex == pageIndex ? Colors.white : MColors.light_text_color,
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
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: MColors.whiteE, boxShadow: [
                        BoxShadow(color: MColors.coolGrey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5, offset: Offset(1, 4))
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
              child: Consumer<ClaimsProvider>(
                builder: (context, pr, child) => PageView(
                  children: [
                    pr.selectedIndex == 0
                        ? pr.isStepsFinished
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                margin: EdgeInsets.symmetric(vertical: 2.w),
                                decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    Text(S.of(context).addNewClaim, style: MTextStyles.textMain18),
                                    Gaps.vGap12,
                                    Expanded(
                                      child: Theme(
                                        data: ThemeData(
                                            canvasColor: Colors.white, colorScheme: ColorScheme.light(primary: MColors.primary_color)),
                                        child: Stepper(
                                            elevation: 0,
                                            type: StepperType.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            currentStep: pr.currentStep,
                                            controlsBuilder: (context, details) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(vertical: 3.w),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        pr.currentStep > 0 ? pr.currentStep -= 1 : null;
                                                      },
                                                      child: Text(
                                                        S.of(context).back,
                                                        style: MTextStyles.textMain14.copyWith(fontWeight: FontWeight.w700),
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(MColors.white),
                                                          elevation: MaterialStatePropertyAll(0),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                              side: BorderSide(color: MColors.primary_color))),
                                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                                              EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.symmetric(vertical: 3.w),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        pr.isStepsFinished = !pr.isStepsFinished;
                                                      },
                                                      child: Text(
                                                        "Confirm",
                                                        style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
                                                          elevation: MaterialStatePropertyAll(0),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          )),
                                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                                              EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                                                    ),
                                                  )
                                                ],
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
                                              Step(
                                                title: new Text(''),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: 1.w,
                                                          height: 5.w,
                                                          margin: EdgeInsetsDirectional.only(end: 3.w),
                                                          decoration: BoxDecoration(
                                                              color: MColors.primary_verticalHeader,
                                                              borderRadius: BorderRadius.circular(4)),
                                                        ),
                                                        SvgPicture.asset(
                                                          ImageUtils.getSVGPath("buildings"),
                                                          color: MColors.primary_color,
                                                        ),
                                                        Gaps.hGap8,
                                                        Text("Select Building", style: MTextStyles.textMain16),
                                                      ],
                                                    ),
                                                    GridView.builder(
                                                      itemCount: _unitItems.length,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        childAspectRatio: 1.0,
                                                        crossAxisSpacing: 8.0,
                                                        mainAxisSpacing: 8.0,
                                                      ),
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            pr.selectedBuildingIndex = index;
                                                            selectedBuilding = _unitItems[index];
                                                            Future.delayed(Duration(seconds: 0));
                                                            pr.currentStep < 2 ? pr.currentStep += 1 : null;
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: pr.selectedBuildingIndex == index
                                                                    ? MColors.primary_color
                                                                    : Colors.white,
                                                                borderRadius: BorderRadius.circular(8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: MColors.coolGrey.withOpacity(0.1),
                                                                      spreadRadius: 1,
                                                                      blurRadius: 5,
                                                                      offset: Offset(1, 4))
                                                                ]),
                                                            child: Center(
                                                              child: Text(
                                                                _unitItems[index],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: pr.selectedBuildingIndex == index ? Colors.white : Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                isActive: pr.currentStep >= 0,
                                                state: pr.currentStep >= 1 ? StepState.complete : StepState.disabled,
                                              ),
                                              Step(
                                                title: new Text(''),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
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
                                                        Text("Select Unit", style: MTextStyles.textMain16),
                                                      ],
                                                    ),
                                                    GridView.builder(
                                                      itemCount: _unitItems.length,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        childAspectRatio: 1.0,
                                                        crossAxisSpacing: 8.0,
                                                        mainAxisSpacing: 8.0,
                                                      ),
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            pr.selectedUnitIndex = index;
                                                            selectedUnit = _unitItems[index];
                                                            pr.currentStep < 3 ? pr.currentStep += 1 : null;
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: pr.selectedUnitIndex == index ? MColors.primary_color : Colors.white,
                                                                borderRadius: BorderRadius.circular(8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: MColors.coolGrey.withOpacity(0.1),
                                                                      spreadRadius: 1,
                                                                      blurRadius: 5,
                                                                      offset: Offset(1, 4))
                                                                ]),
                                                            child: Center(
                                                              child: Text(
                                                                _unitItems[index],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: pr.selectedUnitIndex == index ? Colors.white : Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                isActive: pr.currentStep >= 0,
                                                state: pr.currentStep >= 2 ? StepState.complete : StepState.disabled,
                                              ),
                                              Step(
                                                title: new Text(''),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
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
                                                        Text("Select Claim Category", style: MTextStyles.textMain16),
                                                      ],
                                                    ),
                                                    GridView.builder(
                                                      itemCount: _unitItems.length,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        childAspectRatio: 1.0,
                                                        crossAxisSpacing: 8.0,
                                                        mainAxisSpacing: 8.0,
                                                      ),
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            pr.selectedClaimCategoryIndex = index;
                                                            selectedCategory = _unitItems[index];
                                                            pr.currentStep < 4 ? pr.currentStep += 1 : null;
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: pr.selectedClaimCategoryIndex == index
                                                                    ? MColors.primary_color
                                                                    : Colors.white,
                                                                borderRadius: BorderRadius.circular(8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: MColors.coolGrey.withOpacity(0.1),
                                                                      spreadRadius: 1,
                                                                      blurRadius: 5,
                                                                      offset: Offset(1, 4))
                                                                ]),
                                                            child: Center(
                                                              child: Text(
                                                                _unitItems[index],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color:
                                                                      pr.selectedClaimCategoryIndex == index ? Colors.white : Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                isActive: pr.currentStep >= 0,
                                                state: pr.currentStep >= 3 ? StepState.complete : StepState.disabled,
                                              ),
                                              Step(
                                                title: new Text(''),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
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
                                                        Text("Select Claim Sub Category", style: MTextStyles.textMain16),
                                                      ],
                                                    ),
                                                    GridView.builder(
                                                      itemCount: _unitItems.length,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        childAspectRatio: 1.0,
                                                        crossAxisSpacing: 8.0,
                                                        mainAxisSpacing: 8.0,
                                                      ),
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            pr.selectedClaimSubCategoryIndex = index;
                                                            selectedSubCategory = _unitItems[index];
                                                            pr.currentStep < 5 ? pr.currentStep += 1 : null;
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: pr.selectedClaimSubCategoryIndex == index
                                                                    ? MColors.primary_color
                                                                    : Colors.white,
                                                                borderRadius: BorderRadius.circular(8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: MColors.coolGrey.withOpacity(0.1),
                                                                      spreadRadius: 1,
                                                                      blurRadius: 5,
                                                                      offset: Offset(1, 4))
                                                                ]),
                                                            child: Center(
                                                              child: Text(
                                                                _unitItems[index],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: pr.selectedClaimSubCategoryIndex == index
                                                                      ? Colors.white
                                                                      : Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                isActive: pr.currentStep >= 0,
                                                state: pr.currentStep >= 4 ? StepState.complete : StepState.disabled,
                                              ),
                                              Step(
                                                title: new Text(''),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
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
                                                        Text("Select Claim Type", style: MTextStyles.textMain16),
                                                      ],
                                                    ),
                                                    GridView.builder(
                                                      itemCount: _unitItems.length,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        childAspectRatio: 1.0,
                                                        crossAxisSpacing: 8.0,
                                                        mainAxisSpacing: 8.0,
                                                      ),
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            pr.selectedClaimTypeIndex = index;
                                                            selectedType = _unitItems[index];
                                                            pr.currentStep < 6 ? pr.currentStep += 1 : null;
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: pr.selectedClaimTypeIndex == index
                                                                    ? MColors.primary_color
                                                                    : Colors.white,
                                                                borderRadius: BorderRadius.circular(8),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: MColors.coolGrey.withOpacity(0.1),
                                                                      spreadRadius: 1,
                                                                      blurRadius: 5,
                                                                      offset: Offset(1, 4))
                                                                ]),
                                                            child: Center(
                                                              child: Text(
                                                                _unitItems[index],
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color: pr.selectedClaimTypeIndex == index ? Colors.white : Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                isActive: pr.currentStep >= 0,
                                                state: pr.currentStep >= 5 ? StepState.complete : StepState.disabled,
                                              ),
                                              Step(
                                                title: new Text(''),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
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
                                                        Text("Select Available Time", style: MTextStyles.textMain16),
                                                      ],
                                                    ),
                                                    Gaps.vGap10,
                                                    Gaps.vGap12,
                                                    BuildDatePicker(
                                                      provider: provider,
                                                    ),
                                                    Gaps.vGap8,
                                                    BuildTimeDropDown(
                                                      provider: provider,
                                                    ),
                                                    Gaps.vGap8,
                                                    BuildDescriptionField(
                                                      provider: provider,
                                                    ),
                                                    Gaps.vGap8,
                                                    BuildFilePicker(
                                                      provider: provider,
                                                    )
                                                  ],
                                                ),
                                                isActive: pr.currentStep >= 0,
                                                state: pr.currentStep >= 6 ? StepState.complete : StepState.disabled,
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
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
                                        Text(selectedBuilding??"",
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
                                        Text(selectedUnit??"",
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
                                        Text(selectedCategory??"",
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
                                        Text(selectedSubCategory??"",
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
                                        Text(selectedType??"",
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
                                        Text("3/2/2023 - from 12-2 evening ",
                                            style: MTextStyles.textMain14.copyWith(
                                              color: MColors.black,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                    Gaps.vGap30,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
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
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                    side: BorderSide(color: MColors.primary_color))),
                                                padding: MaterialStateProperty.all<EdgeInsets>(
                                                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 3.w),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      SvgPicture.asset(ImageUtils.getSVGPath("done")),
                                                      Text("Confirmation",
                                                          style: MTextStyles.textMain16.copyWith(
                                                            color: MColors.black,
                                                          )),
                                                      Text(
                                                          "Thank you for sumbitting your request.one of our customer services "
                                                              "representatives will contact you shortly,",
                                                          style: MTextStyles.textSubtitle,
                                                      textAlign: TextAlign.center,),
                                                      Gaps.vGap8,
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          pr.isStepsFinished =!pr.isStepsFinished;
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          "Confirm",
                                                          style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                                                        ),
                                                        style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
                                                            elevation: MaterialStatePropertyAll(0),
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            )),
                                                            padding: MaterialStateProperty.all<EdgeInsets>(
                                                                EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w))),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Confirm",
                                              style: MTextStyles.textWhite14.copyWith(fontWeight: FontWeight.w700),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(MColors.primary_color),
                                                elevation: MaterialStatePropertyAll(0),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
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
                                itemCount: pr.claimsList.length,
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
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
                                                "Request Code:" + " #123-45-567",
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
                                              child: Text(provider?.claimsList[index]?.status ?? '',
                                                  style: MTextStyles.textDark12
                                                      .copyWith(color: MColors.blueButtonColor, fontWeight: FontWeight.w600)))
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
                                                "Unit Name",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                                "Unit Name",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                                "Client ID",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                                "Start AT",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                                "End AT",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                  decoration: BoxDecoration(color: MColors.white, borderRadius: BorderRadius.circular(8)),
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
                                                "Request Code:" + " #123-45-567",
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
                                                  style: MTextStyles.textDark12
                                                      .copyWith(color: MColors.blueButtonColor, fontWeight: FontWeight.w600)))
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
                                                "Unit Name",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                                "Unit Name",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                                "Client ID",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                                "Start AT",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                                                "End AT",
                                                style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
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
                ),
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
    return ClaimsPresenter();
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
