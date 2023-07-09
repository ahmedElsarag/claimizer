import 'package:Cliamizer/res/colors.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/UnitDetailsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../network/models/claim_available_time_response.dart';
import '../../../res/styles.dart';

class BuildUnlinkStatusDropDown extends StatelessWidget {
  const BuildUnlinkStatusDropDown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitDetailsProvider>(
      builder: (context, pr, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MColors.textFieldBorder),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              S.of(context).unitStatus,
              style: MTextStyles.textMain14.copyWith(color: MColors.black),
            ),
            value: pr.unlinkStatus,
            onChanged: (String newValue) {
              pr.unlinkStatus = newValue;
            },
            items: [
              // DropdownMenuItem(child: Text(S.of(context).unlinkStatus), value: ''),
              DropdownMenuItem(child: Text(S.of(context).finished), value: 'finished'),
              DropdownMenuItem(child: Text(S.of(context).terminated), value: 'terminated'),
              DropdownMenuItem(child: Text(S.of(context).canceled), value: 'canceled'),
            ],
          ),
        ),
      ),
    );
  }
}
