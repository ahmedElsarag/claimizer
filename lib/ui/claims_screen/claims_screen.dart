import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/image_utils.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../res/styles.dart';
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

  List<String> _unitItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'I'
        'tem 9',
    'Item 10'
  ];

  @override
  void initState() {
    mPresenter.getAllClaimsApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ClaimsProvider>(
      builder: (context, value, child) => Scaffold(
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
                            decoration:
                                BoxDecoration(color: MColors.primary_color, borderRadius: BorderRadius.circular(4)),
                          ),
                          Text(S.of(context).claimManagement, style: MTextStyles.textMain18),
                        ],
                      ),
                      Gaps.vGap16,
                      Container(
                        height: 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cardTitles.length,
                          itemBuilder: (context, pageIndex) {
                            return GestureDetector(
                              onTap: () {
                                provider.selectedIndex = pageIndex;
                              },
                              child: Card(
                                elevation: 0.5,
                                color: provider.selectedIndex == pageIndex ? MColors.primary_color : Colors.white,
                                child: SizedBox(
                                  width: 25.w,
                                  height: 96,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        ImageUtils.getSVGPath(cardImages[pageIndex]),
                                        color:
                                            provider.selectedIndex == pageIndex ? Colors.white : MColors.primary_color,
                                      ),
                                      SizedBox(
                                        width: provider.selectedIndex == pageIndex ? 70 : 80,
                                        child: Text(
                                          cardTitles[pageIndex],
                                          style: MTextStyles.textMainLight14.copyWith(
                                              color: provider.selectedIndex == pageIndex
                                                  ? Colors.white
                                                  : MColors.light_text_color,
                                              fontSize: provider.selectedIndex == pageIndex ? 14 : 12),
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
                  child: PageView(
                    children: [
                      provider.selectedIndex == 0
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
                                          canvasColor: Colors.white,
                                          colorScheme: ColorScheme.light(primary: MColors.primary_color)),
                                      child: Stepper(
                                    elevation: 0,
                                          type: StepperType.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          currentStep: provider.currentStep,
                                          controlsBuilder: (context, details) {
                                            return Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    provider.currentStep > 0 ? provider.currentStep -= 1 : null;
                                                  },
                                                  child: Text(
                                                    'Back',
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
                                              ],
                                            );
                                          },
                                    onStepTapped: (step) {
                                      provider.currentStep = step;
                                    },
                                    onStepContinue: () {
                                      provider.currentStep < 2 ? provider.currentStep += 1 : null;
                                    },
                                    onStepCancel: () {
                                      provider.currentStep > 0 ? provider.currentStep -= 1 : null;
                                    },
                                          steps: [
                                      Step(
                                        title: new Text(''),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 1.w,
                                                        height: 5.w,
                                                        margin: EdgeInsetsDirectional.only(end: 2.w),
                                                        decoration: BoxDecoration(
                                                            color: MColors.primary_color,
                                                            borderRadius: BorderRadius.circular(4)),
                                                      ),
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
                                                          provider.selectedUnitIndex = index;
                                                          provider.currentStep < 2 ? provider.currentStep += 1 : null;
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: provider.selectedUnitIndex == index
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
                                                                color: provider.selectedUnitIndex == index
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
                                              isActive: provider.currentStep >= 0,
                                              state:
                                                  provider.currentStep >= 1 ? StepState.complete : StepState.disabled,
                                            ),
                                      Step(
                                        title: new Text(''),
                                        content: Column(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                provider.currentStep < 2 ? provider.currentStep += 1 : null;
                                              },
                                              child: Text("Data2"),
                                            )
                                          ],
                                        ),
                                        isActive: provider.currentStep >= 0,
                                        state: provider.currentStep >= 2 ? StepState.complete : StepState.disabled,
                                      ),
                                      Step(
                                        title: new Text(''),
                                        content: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              decoration: InputDecoration(labelText: 'Email'),
                                            ),
                                          ],
                                        ),
                                        isActive: provider.currentStep >= 0,
                                        state: provider.currentStep >= 3 ? StepState.complete : StepState.disabled,
                                      ),
                                      Step(
                                        title: new Text(''),
                                        content: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              decoration: InputDecoration(labelText: 'Email'),
                                            ),
                                          ],
                                        ),
                                        isActive: provider.currentStep >= 0,
                                        state: provider.currentStep >= 4 ? StepState.complete : StepState.disabled,
                                      ),
                                      Step(
                                        title: new Text(''),
                                        content: Column(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {},
                                              child: Text("Data"),
                                            )
                                          ],
                                        ),
                                        isActive: provider.currentStep >= 0,
                                        state: provider.currentStep >= 5 ? StepState.complete : StepState.disabled,
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      )
                          : provider.selectedIndex == 1
                          ? ListView.builder(
                        itemCount: provider.claimsList.length,
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
                                                  style: MTextStyles.textDark12.copyWith(
                                                      color: MColors.blueButtonColor, fontWeight: FontWeight.w600)))
                                ],
                              ),
                              buildDivider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Unit Name",
                                        style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                      ),
                                      Gaps.vGap8,
                                      Text(
                                        "Unit Name",
                                        style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                      ),
                                      Gaps.vGap8,
                                      Text(
                                        "Client id",
                                        style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                      ),
                                      Gaps.vGap8,
                                      Text(
                                        "Start AT",
                                        style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                      ),
                                      Gaps.vGap8,
                                      Text(
                                        "End AT",
                                        style: MTextStyles.textBoldDark12.copyWith(color: MColors.subtitlesColor),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        provider?.claimsList[index]?.startAt ?? '',
                                                style: MTextStyles.textSubtitle,
                                              ),
                                      Gaps.vGap8,
                                      Text(
                                        "Falcon Tower A5 - Owned",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                      Gaps.vGap8,
                                      Text(
                                        "345567890",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                      Gaps.vGap8,
                                      Text(
                                        "2023-03-06",
                                        style: MTextStyles.textSubtitle,
                                      ),
                                      Gaps.vGap8,
                                      Text(
                                        "2024-03-04",
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
                          : Container(
                        decoration: BoxDecoration(color: MColors.rejected_color, borderRadius: BorderRadius.circular(8)),
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
                                  color: MColors.whiteE,
                                ),
                                child: SvgPicture.asset(ImageUtils.getSVGPath("export")),
                              ),
                            ),
                          ],
                        ), /*Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: SearchField()),
                          SvgPicture.asset(ImageUtils.getSVGPath("filter")),
                          SvgPicture.asset(ImageUtils.getSVGPath("export"))
                        ],
                      ),*/
                              ),
                  ],
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
