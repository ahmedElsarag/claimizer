import 'package:flutter/material.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DefaultSFDateRangePicker extends StatefulWidget {
  final List<DateTime> blackOutDates;
  final List<DateTime> selectedDates;
  final List<int> weekendDays;
  final Function onChanged;
  final bool isFromCheckin;
  final bool toggleDaySelection;
  final DateRangePickerSelectionMode selectionMode;

  const DefaultSFDateRangePicker({Key key, this.blackOutDates, this.onChanged, this.selectionMode, this.weekendDays, this.isFromCheckin = false , this.selectedDates, this.toggleDaySelection = true}) : super(key: key);

  @override
  State<DefaultSFDateRangePicker> createState() => _DefaultSFDateRangePickerState();
}

class _DefaultSFDateRangePickerState extends State<DefaultSFDateRangePicker> {
  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      // minDate: widget.isFromCheckin?widget.selectedDates[0]:DateTime.now(),
      // maxDate: widget.isFromCheckin?(widget.selectedDates.length==1?widget.selectedDates[0].add(Duration(days: 1)):widget.selectedDates[1]):null,
      view: DateRangePickerView.month,
      selectionColor: MColors.primary_color,
      selectionTextStyle: TextStyle(color: MColors.white),
      showNavigationArrow: true,
      enablePastDates: false,
      toggleDaySelection: widget.toggleDaySelection,
      todayHighlightColor: MColors.primary_color,
      startRangeSelectionColor: MColors.primary_color,
      endRangeSelectionColor: MColors.primary_color,
      rangeSelectionColor: Theme.of(context).highlightColor,
      selectionShape: DateRangePickerSelectionShape.rectangle,
      monthCellStyle: DateRangePickerMonthCellStyle(
        todayTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.shadow
        ),
        textStyle: widget.isFromCheckin?TextStyle(
            color: Theme.of(context).focusColor,
            decoration: TextDecoration.lineThrough
        ) :TextStyle(
            color: Theme.of(context).colorScheme.shadow
        ) ,
        blackoutDateTextStyle: TextStyle(
            color: Theme.of(context).focusColor,
            decoration: TextDecoration.lineThrough
        ),
        weekendTextStyle: TextStyle(
            color: Theme.of(context).focusColor,
            decoration: TextDecoration.lineThrough
        ),
        specialDatesTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.shadow
        )
      ),
      monthViewSettings:
      DateRangePickerMonthViewSettings(
        enableSwipeSelection: true,
        firstDayOfWeek: 1,
        blackoutDates: widget.blackOutDates,
        weekendDays: widget.weekendDays,
        specialDates: widget.selectedDates
      ),
      headerStyle: DateRangePickerHeaderStyle(
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.shadow,
        ),
      ),
      onSelectionChanged: widget.onChanged,
      selectionMode:widget.selectionMode,
    );
  }
}
