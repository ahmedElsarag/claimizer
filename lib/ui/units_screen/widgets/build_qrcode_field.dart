import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/res/styles.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';

class BuildQRCodeField extends StatelessWidget {
  const BuildQRCodeField({Key key, this.provider}) : super(key: key);
  final UnitProvider provider;

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => TextFormField(
        controller: pr.qrCode,
        style: MTextStyles.textNormal12,
        maxLines: null,
        decoration: InputDecoration(
          hintText: S.of(context).qrCode,
          hintStyle: MTextStyles.textMain14.copyWith(color: MColors.light_text_color, fontWeight: FontWeight.w500),
          // suffixIcon: SvgPicture.asset(ImageUtils.getSVGPath('scan')),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: MColors.textFieldBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: MColors.textFieldBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: MColors.textFieldBorder),
          ),
        ),
        // onChanged: (value) {
        //   pr.qrCode.text = value;
        // },
      ),
    );
  }
}
