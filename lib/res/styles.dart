import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimens.dart';

class MTextStyles {
  static const TextStyle textMain12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: MColors.primary_color,
  );
  static const TextStyle textMain14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: MColors.primary_color,
  );
  static TextStyle textMainLight16 =
      GoogleFonts.montserrat(fontSize: Dimens.font_sp16, fontWeight: FontWeight.w500, color: MColors.light_text_color.withOpacity(0.8));
  static TextStyle textMain18 =
      GoogleFonts.montserrat(fontSize: Dimens.font_sp18, fontWeight: FontWeight.w600, color: MColors.primary_text_color);
  static const TextStyle textNormal12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: MColors.text_normal,
  );
  static TextStyle textDark12 = GoogleFonts.montserrat(fontSize: Dimens.font_sp12, fontWeight: FontWeight.w500, color: MColors.text_dark);

  static const TextStyle textWhiteDD12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: MColors.white_dd,
  );

  static const TextStyle textWhite12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: MColors.white,
  );

  static const TextStyle textBoldWhite14 = const TextStyle(fontSize: Dimens.font_sp14, color: MColors.white, fontWeight: FontWeight.bold);

  static TextStyle textDark14 = GoogleFonts.montserrat(fontSize: Dimens.font_sp14, fontWeight: FontWeight.w500, color: MColors.text_dark);
  static TextStyle textWhite14 = GoogleFonts.montserrat(fontSize: Dimens.font_sp14, fontWeight: FontWeight.w500, color: MColors.white);


  static const TextStyle textWhiteDD14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: MColors.white_dd,
  );

  static const TextStyle textBoldDD14 = const TextStyle(fontSize: Dimens.font_sp14, color: MColors.white_dd, fontWeight: FontWeight.bold);

  static const TextStyle textBoldWhite16 = const TextStyle(fontSize: Dimens.font_sp16, color: MColors.white, fontWeight: FontWeight.bold);

  static const TextStyle textDark16 = const TextStyle(
    fontSize: Dimens.font_sp16,
    color: MColors.text_dark,
  );
  static const TextStyle textBoldDark14 =
      const TextStyle(fontSize: Dimens.font_sp14, color: MColors.text_dark, fontWeight: FontWeight.bold);

  static const TextStyle textBoldDark12 =
      const TextStyle(fontSize: Dimens.font_sp12, color: MColors.text_dark, fontWeight: FontWeight.bold);
  static const TextStyle textBoldDark16 =
      const TextStyle(fontSize: Dimens.font_sp16, color: MColors.text_dark, fontWeight: FontWeight.bold);
  static const TextStyle textBoldDark18 =
      const TextStyle(fontSize: Dimens.font_sp18, color: MColors.text_dark, fontWeight: FontWeight.bold);
  static const TextStyle textBoldDark24 = const TextStyle(fontSize: 24.0, color: MColors.text_dark, fontWeight: FontWeight.bold);

  static const TextStyle textBoldDark20 = const TextStyle(fontSize: 20.0, color: MColors.text_dark, fontWeight: FontWeight.bold);

  static const TextStyle textBoldDark26 = const TextStyle(fontSize: 26.0, color: MColors.text_dark, fontWeight: FontWeight.bold);
  static const TextStyle textGray10 = const TextStyle(
    fontSize: Dimens.font_sp10,
    color: MColors.text_gray,
  );

  static TextStyle textGray12 = GoogleFonts.montserrat(fontSize: Dimens.font_sp12, fontWeight: FontWeight.w400, color: MColors.primary_light_color);

  static const TextStyle textGray14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: MColors.text_gray,
  );
  static TextStyle textGray16 =
      GoogleFonts.montserrat(fontSize: Dimens.font_sp16, fontWeight: FontWeight.w600, color: MColors.dark_text_color);
  static TextStyle textDarkGray12 =
      GoogleFonts.montserrat(fontSize: Dimens.font_sp12, fontWeight: FontWeight.w600, color: MColors.dark_text_color);
  static TextStyle textLabelSmall =
      GoogleFonts.montserrat(fontSize: Dimens.font_sp12, fontWeight: FontWeight.w500, color: MColors.primary_light_color);
}
