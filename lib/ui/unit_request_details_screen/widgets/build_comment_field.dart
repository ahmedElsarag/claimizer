import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsPresenter.dart';
import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/styles.dart';
import '../UnitDetailsProvider.dart';

class BuildCommentField extends StatelessWidget {
  const BuildCommentField({Key key, this.provider}) : super(key: key);
  final UnitDetailsProvider provider;
  @override
  Widget build(BuildContext context) {
    return Consumer<UnitDetailsProvider>(
      builder: (context, pr, child) =>  TextFormField(
        controller: pr.comment,
        maxLines: null,
        style: MTextStyles.textDark14,
        decoration: InputDecoration(
          hintText: S.of(context).comment,
          hintStyle: MTextStyles.textMain14.copyWith(
              color: MColors.light_text_color
          ),
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
      ),
    );
  }
}
