import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/colors.dart';
import 'HeadlineWithIcon.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String headLine;
  final inputFormater;
  var inputType;
  final TextEditingController controller;
  final Function(String) validation;
  final Function (String) onChanged;
  final Function (String) onSaved;
  CustomTextFormField(
      {this.headLine,
        this.inputType,
        this.hintText,
        this.validation,
        this.controller, this.onChanged, this.onSaved, this.inputFormater});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headLine,
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(color: MColors.black),
        ),
        Container(
          margin: EdgeInsets.only(top: 1.h, bottom: 3.h),
          child: TextFormField(
            inputFormatters: inputFormater,
            validator: validation ?? (val) {},
            onSaved: onSaved ?? (val) {},
            onChanged: onChanged ?? (val) {},
            keyboardType: inputType ?? TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: controller,
            style: Theme.of(context).textTheme.caption,
            // autovalidateMode: AutovalidateMode.always,
            decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).primaryColorLight,
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Theme.of(context).focusColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Theme.of(context).focusColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Theme.of(context).focusColor))),
          ),
        ),
      ],
    );
  }
}

class CustomPasswordTextFormField extends StatelessWidget {
  final String hintText;
  final String headLine;
  final Widget suffix;
  final bool obscurePass;
  final Function(String) validation;

  CustomPasswordTextFormField(
      {this.headLine,
        this.hintText,
        this.suffix,
        this.obscurePass,
        this.validation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildHeadline(
          text: headLine,
        ),
        Container(
          margin: EdgeInsets.only(right: 6.w, left: 6.w, bottom: 3.h),
          child: TextFormField(
            validator: validation ?? (val) {},
            obscureText: obscurePass,
            decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).primaryColorLight,
                suffixIcon: suffix,
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Theme.of(context).focusColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Theme.of(context).focusColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Theme.of(context).focusColor))),
          ),
        ),
      ],
    );
  }
}
