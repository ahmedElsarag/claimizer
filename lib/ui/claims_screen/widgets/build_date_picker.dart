import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/colors.dart';

class BuildDatePicker extends StatelessWidget {
  const BuildDatePicker({Key key, this.provider}) : super(key: key);
  final ClaimsProvider provider;

  Future<void> _selectDate(BuildContext context, DateTime selectDate) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectDate == null ? DateTime.now() : selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectDate) {
      selectDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClaimsProvider>(
      builder: (context, pr, child) => TextFormField(
        controller: TextEditingController(text: pr.selectedDate.toString() ?? ""),
        readOnly: true,
        decoration: InputDecoration(
            hintText: 'Select Date',
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
            suffixIcon: InkWell(
              onTap: () async {
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: pr.selectedDate == null ? DateTime.now() : pr.selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null && picked != pr.selectedDate) {
                  pr.selectedDate = picked;
                }
                print("Selected Date :${pr.selectedDate}");
              },
              child: Icon(Icons.calendar_month_rounded),
            )),
        onChanged: (value) {
          pr.selectedDate = value as DateTime;
        },
      ),
    );
  }
}
