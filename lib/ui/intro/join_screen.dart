import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Cliamizer/ui/intro/widgets/language.dart';
import 'package:sizer/sizer.dart';

import '../../CommonUtils/log_utils.dart';
import '../../CommonUtils/preference/Prefs.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../res/setting.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({Key key}) : super(key: key);

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  //---------------
  int selectedLang;
  Language lang;
  String languageSelected = "Eng";
  int languageSelectedValue = 1;

  @override
  void initState() {
    super.initState();
    setLanguage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              MColors.primary_color.withOpacity(.94),
              MColors.primary_light_color.withOpacity(.9),
            ]
            )),
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 82.h,
              child: SvgPicture.asset('assets/images/svg/join.svg',fit: BoxFit.fitWidth,),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 5.h,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 70,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerEnd,
                    child: DropdownButton(
                      dropdownColor: Colors.black.withOpacity(0.75),
                      isExpanded: true,
                      style: TextStyle(color: Colors.white),
                      borderRadius: BorderRadius.circular(12.0),
                      underline: SizedBox(),
                      onChanged: (Language newValue) {
                        setState(() {
                          lang = newValue;
                          setSelected(lang.languageCode);
                        });
                      },
                      // onChanged: _changeLanguageName,
                      hint: lang == null
                          ? Text(
                        languageSelected,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'PFBagueRoundPro'
                        ),
                      ) : Text(
                        "${lang.language}",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PFBagueRoundPro',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: MColors.white,
                        size: 26.sp,
                      ),
                      items: Language.languageList()
                          .map<DropdownMenuItem<Language>>(
                              (lang) => DropdownMenuItem(
                              value: lang,
                              child: Text(
                                lang.language,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.w500),
                              )))
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  height:45.h,
                  padding: EdgeInsets.only(top: 8.h),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/images/svg/logo.svg',width: 24.h),
                      SizedBox(height: 6.h,),
                      Container(
                        width: 50.w,
                        child: Text(
                          S.of(context).joinText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: MColors.white5
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset('assets/images/svg/welcom_logo.svg',width: 24.h),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 100.w,
                            height: 6.h,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MColors.btn_color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                                onPressed: (){},
                                child: Text(S.of(context).login,style: TextStyle(fontSize: 14.sp,color: MColors.dark_text_color,fontWeight: FontWeight.bold),)),
                          ),
                          SizedBox(height: 2.h,),
                          Container(
                            width: 100.w,
                            height: 6.h,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                      side: BorderSide(color: MColors.white5,width: 1.5)
                                ),
                                onPressed: (){},
                                child: Text(S.of(context).register,style: TextStyle(fontSize: 14.sp,color: MColors.white5,fontWeight: FontWeight.bold),)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
              // onPageChanged: onChangedFunction,
            ),
          ],
        ),
      ),
    );
  }

  void setLanguage() async {
    await Prefs.getAppLocal.then((value) => {
      print(value),
      if (value != null)
        {
          if (value == "ar")
            {
              languageSelected = 'AR',
              languageSelectedValue = 1,
            }
          else
            {
              languageSelected = 'Eng',
              languageSelectedValue = 0,
            }
        }
    });
    setState(() {});
  }

  void setSelected(String s) {
    if (s == 'en' || s == 'null')
      Setting.mobileLanguage.value = new Locale('en');
    else
      Setting.mobileLanguage.value = new Locale('ar');
    Prefs.setAppLocal(s);
    Log.d(s);
  }
}
