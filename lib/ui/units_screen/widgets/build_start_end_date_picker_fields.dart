import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../res/colors.dart';

class StartEndDatePickerField extends StatefulWidget {
  @override
  _StartEndDatePickerFieldState createState() => _StartEndDatePickerFieldState();
}

class _StartEndDatePickerFieldState extends State<StartEndDatePickerField> {
  DateTime _startDate;
  DateTime _endDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy',"en");

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _startDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _endDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, pr, child) => Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async{
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: pr.startDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now().add(Duration(days: 1000)));
                if (picked != null) {
                    pr.startDate = picked;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: MColors.textFieldBorder),
                ),
                padding: EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pr.startDate != null
                          ? _dateFormat.format(pr.startDate)
                          : S.of(context).startDate,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: GestureDetector(
              onTap: () async{
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: pr.endDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now().add(Duration(days: 1000)));
                if (picked != null) {
                    pr.endDate = picked;
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
                      pr.endDate != null
                          ? _dateFormat.format(pr.endDate)
                          : S.of(context).endDate,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
