import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
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
        controller: pr.description,
        maxLines: 3,
        style: MTextStyles.textDark14,
        validator: (val){
          if(val.isEmpty){
            return S.of(context).descriptionRequired;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: S.of(context).writeYourThoughtsHere,
          hintStyle: MTextStyles.textMain14.copyWith(
              color: MColors.secondary_text_color
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
