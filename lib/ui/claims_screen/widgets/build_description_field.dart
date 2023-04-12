import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/styles.dart';

class BuildDescriptionField extends StatelessWidget {
  const BuildDescriptionField({Key key, this.provider}) : super(key: key);
  final ClaimsProvider provider;
  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (context, pr, child) =>  TextFormField(
        controller: TextEditingController(text:pr.description),
        maxLines: null,
        style: MTextStyles.textDark14,
        decoration: InputDecoration(
          hintText: S.of(context).writeYourThoughtsHere,
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
