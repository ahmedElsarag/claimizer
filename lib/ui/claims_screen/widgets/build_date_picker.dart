import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../CommonUtils/image_utils.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../res/styles.dart';

class BuildDatePicker extends StatelessWidget {
  BuildDatePicker({Key key, this.provider}) : super(key: key);
  final ClaimsProvider provider;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd','en');

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (context, pr, child) => GestureDetector(
        onTap: () async {
          final DateTime picked = await showDatePicker(
              context: context,
              initialDate: pr.selectedDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now().add(Duration(days: 1000)));
          if (picked != null) {
            print('@@@@@@@@@@@@${DateFormat('yyyy-MM-dd','en').format(picked)}');
            pr.selectedDate = picked;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: MColors.textFieldBorder),
          ),
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pr.selectedDate != null ? _dateFormat.format(pr.selectedDate) : S.of(context).selectDate,
                style: MTextStyles.textMain14.copyWith(
                    color: MColors.light_text_color
                ),
              ),
              SvgPicture.asset(ImageUtils.getSVGPath("calendar")),
            ],
          ),
        ),
      ),
    );
  }
}
