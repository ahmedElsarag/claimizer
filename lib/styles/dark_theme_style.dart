import 'package:flutter/material.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:sizer/sizer.dart';

import '../res/setting.dart';

class DarkStyle {
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      // colors
      dividerColor: MColors.page_dark_background,
      errorColor: MColors.loginColor1.withOpacity(0.5),
      shadowColor: MColors.primary_color.withOpacity(0.5),
      backgroundColor: MColors.page_dark_background,
      scaffoldBackgroundColor: MColors.page_dark_background,
      primaryColor: MColors.text2_dark_color,
      primaryColorLight: MColors.second_dark_color,
      primaryColorDark: MColors.second_dark_color,
      indicatorColor: MColors.white,
      hintColor: MColors.gray_ce,
      highlightColor: MColors.text2_dark_color.withOpacity(0.4),
      hoverColor: MColors.primary_color.withOpacity(0.5),
      focusColor: MColors.text2_dark_color.withOpacity(0.3),
      disabledColor: Colors.grey,
      canvasColor: MColors.second_dark_color,
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: MColors.page_dark_background,
          onPrimary: MColors.page_dark_background,
          // login gradient
          secondary: MColors.page_dark_background,
          onSecondary: MColors.loginColor1.withOpacity(0.5),
          // login gradient
          error: MColors.page_dark_background,
          onError: MColors.page_dark_background,
          background: MColors.page_dark_background,
          onBackground: MColors.page_dark_background,
          surface: MColors.text_dark_color,
          onInverseSurface: MColors.text_dark_color,
          onSurface: MColors.page_dark_background,
          onPrimaryContainer: MColors.page_dark_background,
          onSecondaryContainer: MColors.loginColor1,
          outline: MColors.white,
          secondaryContainer: MColors.gray_66,
          tertiaryContainer: MColors.text_dark_color.withOpacity(0.2),
          shadow: MColors.text2_dark_color
      ),
      // text theme
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 14.sp,
          color: MColors.text_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        bodyText1: TextStyle(
          fontSize: 16.sp,
          color: MColors.text_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        bodyText2: TextStyle(
          fontSize: 14.sp,
          color: MColors.text_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        caption: TextStyle(
          fontSize: 11.sp,
          color: MColors.text_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        button: TextStyle(
          fontSize: 12.sp,
          color: MColors.text_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        headline1: TextStyle(
          fontSize: 10.sp,
          color: MColors.text2_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        headline2: TextStyle(
          fontSize: 12.sp,
          color: MColors.text_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        headline3: TextStyle(
          fontSize: 13.sp,
          color: MColors.text_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        headline4: TextStyle(
          fontSize: 8.sp,
          color: MColors.text2_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        headline5: TextStyle(
          fontSize: 10.sp,
          color: MColors.text_dark_color,
        ),
        headline6: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: MColors.text2_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        subtitle1: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.bold,
          color: MColors.text_dark_color.withOpacity(0.3),
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        subtitle2: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: MColors.hint_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
        overline: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w700,
          color: MColors.text_dark_color,
          fontFamily: Setting.mobileLanguage.value == Locale("en")
              ? "AirbnbCereal"
              : "Tajawal",
        ),
      ),
      //app themes
      appBarTheme: AppBarTheme(
        backgroundColor: MColors.second_dark_color,
        titleTextStyle: Theme.of(context).textTheme.button.copyWith(
            fontFamily: Setting.mobileLanguage.value == Locale("en")
                ? "AirbnbCereal"
                : "Tajawal",
            color: Theme.of(context).colorScheme.surface),
        elevation: 0.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MColors.page_dark_background,
      ),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: ColorScheme.dark(background: MColors.second_dark_color)),
      cardTheme: CardTheme(
        color: MColors.lightBlack,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: MColors.lightBlack,
      ),
      /*iconTheme: IconThemeData(
        color:  MColors.text2_dark_color : MColors.font_color,
      ),*/
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.sp),
            side: BorderSide(
              color: MColors.darkGrey,
            )),
        fillColor: MaterialStateProperty.all(MColors.darkGrey),
        checkColor: MaterialStateProperty.all(MColors.white),
      ),
      fontFamily: Setting.mobileLanguage.value == Locale("en")
          ? "AirbnbCereal"
          : "Tajawal",
    );
  }
}
