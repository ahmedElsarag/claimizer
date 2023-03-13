import 'package:flutter/material.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../res/setting.dart';

class LightStyles {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      // colors
      dividerColor: MColors.gray_ce,
      errorColor: MColors.error_color,
      shadowColor: MColors.black,
      backgroundColor: MColors.white,
      scaffoldBackgroundColor: MColors.white,
      primaryColor: MColors.primary_color,
      primaryColorLight: MColors.white,
      primaryColorDark: MColors.primary_color,
      indicatorColor: MColors.second_dark_color,
      hintColor: MColors.gray_ef,
      highlightColor: MColors.mainColor70,
      hoverColor: MColors.primary_color,
      focusColor: MColors.hint_color.withOpacity(0.6),
      disabledColor: Colors.grey,
      canvasColor: Colors.grey[50],
      brightness: Brightness.light,

      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: MColors.primary_color,
          onPrimary: MColors.white,
          // login gradient
          secondary: MColors.secondary_text_color,
          onSecondary: MColors.secondary_text_color,
          // login gradient
          error: MColors.loginColor2,
          onError: MColors.loginColor2,
          background: MColors.loginColor2,
          onBackground: MColors.loginColor2,
          surface: MColors.white,
          onInverseSurface: MColors.white,
          onSurface: MColors.primary_text_color,
          surfaceTint: MColors.primary_color,
          onPrimaryContainer: MColors.loginColor2,
          onSecondaryContainer: MColors.gray.withOpacity(0.5),
          outline: MColors.second_dark_color,
          secondaryContainer: MColors.gray_9a,
          tertiaryContainer: MColors.white,
          shadow: MColors.black),
      // text theme
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.montserrat(fontSize: 24.sp, fontWeight: FontWeight.w700, color: MColors.primary_text_color),
        bodyLarge: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w700, color: MColors.primary_text_color),
        bodyMedium: GoogleFonts.montserrat(fontSize: 14.sp, color: MColors.light_text_color,fontWeight: FontWeight.w500),
        bodySmall: GoogleFonts.montserrat(fontSize: 12.sp, color: MColors.primary_text_color),
        labelLarge: GoogleFonts.montserrat(fontSize: 16.sp, color: MColors.primary_text_color),
        displayLarge: GoogleFonts.montserrat(fontSize: 12.sp),
        displayMedium: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600, color: MColors.white),
        displaySmall: GoogleFonts.montserrat(fontSize: 11.sp,color: MColors.light_text_color),
        headlineMedium: GoogleFonts.montserrat(fontSize: 12.sp),
        headlineSmall: GoogleFonts.montserrat(fontSize: 12.sp),
        titleLarge: GoogleFonts.montserrat(fontSize: 12.sp),
        titleMedium: GoogleFonts.montserrat(fontSize: 10.sp,color: MColors.hint_color),
        titleSmall: GoogleFonts.montserrat(fontSize: 11.sp,color: MColors.primary_light_color),
        labelSmall: GoogleFonts.montserrat(fontSize: 9.sp,color: MColors.text_button_color, fontWeight: FontWeight.w500),
        labelMedium: GoogleFonts.montserrat(fontSize: 12.sp,fontWeight: FontWeight.w600, color: MColors.primary_text_color),
      ),
      //app themes
      appBarTheme: AppBarTheme(
        backgroundColor: MColors.primary_color,
        titleTextStyle: Theme.of(context).textTheme.button.copyWith(
            fontFamily: Setting.mobileLanguage.value == Locale("en") ? "PFBagueRoundPro" : "Tajawal",
            color: Theme.of(context).colorScheme.surface),
        elevation: 0.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MColors.page_background,
      ),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: ColorScheme.light(background: MColors.primary_color)),
      cardTheme: CardTheme(
        color: MColors.white,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: MColors.white,
      ),
      /*iconTheme: IconThemeData(
        color: isDarkTheme ? MColors.text2_dark_color : MColors.font_color,
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
      fontFamily: Setting.mobileLanguage.value == Locale("en") ? "PFBagueRoundPro" : "Tajawal",
    );
  }
}
