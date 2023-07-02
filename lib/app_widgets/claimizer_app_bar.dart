import 'package:Cliamizer/res/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../CommonUtils/image_utils.dart';
import '../res/colors.dart';

class ClaimizerAppBar extends StatelessWidget {
  final String title;

  const ClaimizerAppBar({
    Key key,
    this.title,
  }) : super(key: key);
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Setting.mobileLanguage.value != Locale("en")
                ? RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      ImageUtils.getSVGPath("back_icon"),
                    ),
                  )
                : SvgPicture.asset(
                    ImageUtils.getSVGPath("back_icon"),
                  )),
        Expanded(
          child: Center(
            child: Text(
              capitalize(title),
              style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w700, color: MColors.dark_text_color),
            ),
          ),
        )
      ],
    );
  }
}
