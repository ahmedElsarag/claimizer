import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/colors.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({Key key, this.items, this.onChange, this.selectedItem, this.prefixIcon, this.dropdownHeight, this.validator}) : super(key: key);

  final List<String> items;
  final Function(String) onChange;
  final String selectedItem;
  final Icon prefixIcon;
  final dropdownHeight;
  final Function(String) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      child: DropdownSearch<String>(
        mode: Mode.MENU,
        enabled: true,
        items: items,
        dropdownSearchDecoration:
        InputDecoration(
          prefixIcon: prefixIcon,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
          fillColor: MColors.gray_ce.withOpacity(.2),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              BorderSide(color: Theme.of(context).focusColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              BorderSide(color: Theme.of(context).focusColor)),

        ),
        onChanged: (value)=>onChange(value),
        validator: (text) {
          return validator(text);
        },
        selectedItem: selectedItem,

      ),
    );
  }
}
