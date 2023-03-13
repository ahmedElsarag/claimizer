import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Cliamizer/CommonUtils/utils.dart';

import '../res/colors.dart';
import 'CustomTextField.dart';

class AppTextFormField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final Color fillColor;


  const AppTextFormField(
      {this.hint, this.prefixIcon, this.fillColor});

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      dividerColor: Theme.of(context).dividerColor,
      decoration: InputDecoration(
          hintText: hint,
          hoverColor: MColors.primary_color.withOpacity(.1),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          isDense: true,
          prefixIcon: Icon(prefixIcon??Icons.search_rounded, color: MColors.primary_color),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
          focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: MColors.gray_cc)),
          counterText: "",
          hintStyle: TextStyle(color: MColors.coolGrey, fontSize: Utils.sTextSize(20, 5, context)),
          filled: true,
          fillColor: fillColor??MColors.gray_ce.withOpacity(.2)),
      style: TextStyle(color: MColors.primary_text_color, fontSize: Utils.sTextSize(20, 6, context)),
      inputFormatters: [LengthLimitingTextInputFormatter(50)],
      validator: (email) {
        return null;
      },
    );
  }
}
