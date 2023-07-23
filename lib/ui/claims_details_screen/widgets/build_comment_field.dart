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

class BuildCommentField extends StatelessWidget {
  const BuildCommentField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsDetailsProvider>(
      builder: (context, pr, child) =>  TextFormField(
        controller: pr.comment,
        maxLines: 4,
        style: MTextStyles.textDark14,
        decoration: InputDecoration(
          hintText: S.of(context).comment,
          hintStyle: MTextStyles.textMain14.copyWith(
              color: MColors.light_text_color
          ),
          filled: true,
          fillColor: MColors.primary_color.withOpacity(.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
