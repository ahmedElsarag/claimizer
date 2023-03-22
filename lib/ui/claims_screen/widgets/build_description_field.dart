import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../res/colors.dart';

class BuildDescriptionField extends StatelessWidget {
  const BuildDescriptionField({Key key, this.provider}) : super(key: key);
  final ClaimsProvider provider;
  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (context, pr, child) =>  TextFormField(
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Write your thoughts here',
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
        onChanged: (value) {
            pr.description = value;
        },
      ),
    );
  }
}
