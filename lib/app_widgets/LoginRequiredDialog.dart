import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../CommonUtils/preference/Prefs.dart';
import '../generated/l10n.dart';
import '../ui/user/login_screen/LoginScreen.dart';


class LoginRequiredDialog extends StatefulWidget {

  final String message;

  LoginRequiredDialog({Key key, this.message}) : super(key: key);
  @override
  State<LoginRequiredDialog> createState() => _LoginRequiredDialogState();
}

class _LoginRequiredDialogState extends State<LoginRequiredDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, top: 5.h, right: 5.w, bottom: 5.h),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.message??S.of(context).youMustLogin,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 4.h,
          ),
          OutlinedButton(
            child: Text(S.of(context).login),
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>LoginScreen()),(route)=>false);
            },
          )
        ],
      ),
    );
  }
}
