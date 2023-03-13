import 'dart:async';

import 'package:Cliamizer/res/gaps.dart';
import 'package:Cliamizer/ui/user/login_screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/ui/intro/widgets/language.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/setting.dart';
import 'IntroPresenter.dart';
import 'IntroProvider.dart';

class IntroScreen extends StatefulWidget {
  static const String TAG = "/IntroScreen";

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends BaseState<IntroScreen, IntroPresenter> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  IntroProvider mProvider = IntroProvider();

  StreamSubscription _subscription;
  String appVersion = "";
  int currentIndex = 0;
  bool endReached = false;
  PageController _mainPageViewController;
  PageController _textPageViewController;

  double mHeight;
  double mWidth;

  //---------------
  int selectedLang;
  Language lang;
  String languageSelected = "Eng";
  int languageSelectedValue = 1;

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;
    List<String> introText = [
      S.of(context).intro_text_1,
      S.of(context).intro_text_2,
      S.of(context).intro_text_3,
    ];
    List<String> introDescText = [S.of(context).desc1, S.of(context).desc2, S.of(context).desc3];
    List<Color> introColor = [
      MColors.white,
      MColors.white,
      MColors.white,
    ];
    List<Color> introPatternColor = [Color(0xff85195A), Color(0xff326568), Color(0xff694C81)];
    return Scaffold(
      backgroundColor: introColor[currentIndex],
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: 65.h,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                child: PageView(
                  controller: _mainPageViewController,
                  onPageChanged: onChangedFunction,
                  children: List.generate(introText.length, (index) {
                    return SvgPicture.asset(
                      'assets/images/svg/onboarding${currentIndex + 1}.svg',
                    );
                  }),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _textPageViewController, // PageController
                      count: 3,
                      effect: ExpandingDotsEffect(dotHeight: 6, dotColor: MColors.white5, activeDotColor: MColors.rejected_color),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 45),
                      height: 15.h,
                      child: PageView(
                        controller: _textPageViewController,
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: onChangedFunction,
                        children: List.generate(introText.length, (index) {
                          return Column(
                            children: [
                              Text(
                                introText[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: MColors.primary_text_color,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Gaps.vGap12,
                              Text(
                                introDescText[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: MColors.secondary_text_color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: GestureDetector(
                        child: Container(
                            child: endReached
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Colors.redAccent,
                                    ),
                                    child: Text(
                                      S.of(context).getStarted,
                                      style: TextStyle(color: MColors.white, fontWeight: FontWeight.w700, fontSize: 13.sp),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 3.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(40)),
                                      color: Colors.redAccent,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: MColors.white,
                                    ))),
                        onTap: () {
                          if (!endReached)
                            _mainPageViewController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.decelerate);
                          else {
                            _openLoginScreen(context);
                          }
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // onPageChanged: onChangedFunction,
          ),
          Visibility(
            visible: !endReached,
            child: PositionedDirectional(
              top: 8.h,
              end: 6.w,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    color: MColors.btn_color,
                  ),
                  child: Text(
                    S.of(context).skip,
                    style: TextStyle(color: MColors.primary_text_color, fontWeight: FontWeight.w500, fontSize: 12.5.sp),
                  ),
                ),
                onTap: () {
                  if (!endReached)
                    _mainPageViewController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.decelerate);
                  else {
                    _openLoginScreen(context);
                  }
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
          // PositionedDirectional(
          //   top: 8.h,
          //   start: 6.w,
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Container(
          //       width: 70,
          //       margin: EdgeInsets.symmetric(horizontal: 20),
          //       child: DropdownButton(
          //         dropdownColor: Colors.black.withOpacity(0.75),
          //         isExpanded: true,
          //         style: TextStyle(color: Colors.blue),
          //         borderRadius: BorderRadius.circular(12.0),
          //         underline: SizedBox(),
          //         onChanged: (Language newValue) {
          //           setState(() {
          //             lang = newValue;
          //             setSelected(lang.languageCode);
          //           });
          //         },
          //         // onChanged: _changeLanguageName,
          //         hint: lang == null
          //             ? Text(
          //           languageSelected,
          //           style:
          //           TextStyle(color: Colors.blue, fontSize: 12.sp, fontWeight: FontWeight.w600, fontFamily: 'PFBagueRoundPro'),
          //         )
          //             : Text(
          //           "${lang.language}",
          //           style: TextStyle(
          //             color: Colors.blue,
          //             fontFamily: 'PFBagueRoundPro',
          //             fontWeight: FontWeight.w600,
          //             fontSize: 12.sp,
          //           ),
          //         ),
          //         icon: Icon(
          //           Icons.keyboard_arrow_down_rounded,
          //           color: MColors.black,
          //           size: 26.sp,
          //         ),
          //         items: Language.languageList()
          //             .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
          //             value: lang,
          //             child: Text(
          //               lang.language,
          //               style: TextStyle(color: Colors.white, fontSize: 12.sp, fontFamily: 'Tajawal', fontWeight: FontWeight.w500),
          //             )))
          //             .toList(),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Future isUserLoggedIn() async {
    await Prefs.isLogin ? _openHomeScreen(context) : _openLoginScreen(context);
  }

  _openLoginScreen(context) {
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginScreen()));
  }

  _openHomeScreen(context) {
    // LoginResponse response;
    // Prefs.getCurrentUser.then((value) => {
    //       response = LoginResponse.fromJson(json.decode(value)),
    //       if (response.data.role == "student")
    //         {
    //           NavigatorUtils.push(context, MainRouter.MainPage,
    //               replace: true, clearStack: true)
    //         }
    //       else
    //         {
    //           NavigatorUtils.push(context, DoctorMainRouter.DoctorMainPage,
    //               replace: true, clearStack: true)
    //         }
    //     });
  }

  @override
  void initState() {
    super.initState();
    setLanguage();
    _textPageViewController = PageController(initialPage: 0, viewportFraction: 1);
    _mainPageViewController = PageController(initialPage: 0)..addListener(_onMainScroll);
  }

  void setLanguage() async {
    await Prefs.getAppLocal.then((value) => {
          print(value),
          if (value != null)
            {
              if (value == "ar")
                {
                  languageSelected = 'AR',
                  languageSelectedValue = 1,
                }
              else
                {
                  languageSelected = 'Eng',
                  languageSelectedValue = 0,
                }
            }
        });
    setState(() {});
  }

  void setSelected(String s) {
    if (s == 'en' || s == 'null')
      Setting.mobileLanguage.value = new Locale('en');
    else
      Setting.mobileLanguage.value = new Locale('ar');
    Prefs.setAppLocal(s);
    Log.d(s);
  }

  @override
  void dispose() {
    super.dispose();
    if (_subscription != null) {
      _subscription.cancel();
    }
    _mainPageViewController.dispose();
    _textPageViewController.dispose();
  }

  @override
  IntroPresenter createPresenter() {
    return IntroPresenter();
  }

  @override
  bool get wantKeepAlive => true;

  _goToPage(int page) {
    _textPageViewController.animateToPage(page, duration: Duration(milliseconds: 50), curve: Curves.decelerate);
    _mainPageViewController.animateToPage(page, duration: Duration(milliseconds: 40), curve: Curves.decelerate);
  }

  _onMainScroll() {
    _textPageViewController.animateToPage(currentIndex, duration: Duration(milliseconds: 200), curve: Curves.decelerate);
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
      endReached = currentIndex == 2;
    });
  }
}
