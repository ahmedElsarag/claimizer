import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsPresenter.dart';
import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/UnitDetailsProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/styles.dart';

class BuildRenewNotesField extends StatelessWidget {
  const BuildRenewNotesField({Key key, this.provider}) : super(key: key);
  final UnitDetailsProvider provider;
  @override
  Widget build(BuildContext context) {
    return Consumer<UnitDetailsProvider>(
      builder: (context, pr, child) =>  TextFormField(
        controller: pr.renewNotes,
        maxLines: 4,
        style: MTextStyles.textDark14,
        decoration: InputDecoration(
          hintText: S.of(context).renewNotes,
          hintStyle: MTextStyles.textMain14.copyWith(
              color: MColors.light_text_color
          ),
          fillColor: MColors.primary_color.withOpacity(.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
