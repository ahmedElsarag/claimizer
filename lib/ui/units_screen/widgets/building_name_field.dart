import 'package:Cliamizer/res/styles.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';

class BuildingNameField extends StatelessWidget {
  const BuildingNameField({Key key, this.provider}) : super(key: key);
  final UnitProvider provider;

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => Container(
        height: MediaQuery.of(context).size.height * .06,
        child: TextFormField(
          controller: TextEditingController(text: pr.isBuilding? pr.linkListRequestDataBean.building: pr.newLinkRequestDataBean.building??""),
          readOnly: true,
          style: MTextStyles.textDark14,
          decoration: InputDecoration(
            hintText: S.of(context).buildingName,
            hintStyle: MTextStyles.textMain14.copyWith(color: MColors.light_text_color, fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
