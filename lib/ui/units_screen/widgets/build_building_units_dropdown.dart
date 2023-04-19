import 'package:Cliamizer/res/colors.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../../network/models/NewLinkListRequestResponse.dart';
import '../../../res/styles.dart';

class BuildBuildingUnitDropDown extends StatelessWidget {
  const BuildBuildingUnitDropDown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MColors.textFieldBorder),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              S.of(context).selectUnit,
              style: MTextStyles.textMain14.copyWith(color: MColors.light_text_color),
            ),
            value: pr.selectedUnit,
            onChanged: (String newValue) {
              pr.selectedUnit = newValue;
              print("%%%%%%%%%%%%%%%%%%%%%%%%% $newValue");
            },
            items: pr.buildingUnitsList.map((UnitsList value) {
              return DropdownMenuItem<String>(
                value: value.code,
                child: Text(value.propertyName),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
