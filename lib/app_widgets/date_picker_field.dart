import 'package:flutter/material.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DatePickerField extends StatelessWidget {
  final String hintText;
  final Function(String) validation;
  final Function (String) onChanged;
  final Function (String) onSaved;
  DatePickerField(
      {this.hintText,
        this.validation,
         this.onChanged, this.onSaved});

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validation ?? (val) {},
      onSaved: onSaved??(val){},
      onChanged: onChanged??(val){},
      style: Theme.of(context).textTheme.caption,
      readOnly: true,
      decoration: InputDecoration(
          filled: true,
          fillColor: MColors.gray_ce.withOpacity(.3),
          hintText: hintText,
          suffixIcon: GestureDetector(
            onTap: ()=>showDialog(context),
              child: Icon(Icons.date_range_rounded,color: MColors.primary_color,size: 16.sp,)),
          hintStyle: TextStyle(color: MColors.primary_text_color),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              BorderSide(color: Theme.of(context).focusColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              BorderSide(color: Theme.of(context).focusColor)),
          ),
    );
  }
  void showDialog(context)async{
    DateTime date = await showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2010),lastDate: DateTime(2030));
    if(date!=null)
    controller.text = DateFormat.yMMMd('en').format(date);
  }
}