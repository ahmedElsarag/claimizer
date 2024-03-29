import 'dart:io';
import 'dart:math';

import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/res/gaps.dart';
import 'package:Cliamizer/res/styles.dart';
import 'package:Cliamizer/ui/user/login_screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../CommonUtils/log_utils.dart';
import '../../../CommonUtils/preference/Prefs.dart';
import '../../../CommonUtils/utils.dart';
import '../../../app_widgets/CustomTextField.dart';
import '../../../generated/l10n.dart';
import '../../../network/models/LoginResponse.dart';
import '../../../res/colors.dart';
import '../../../res/setting.dart';
import 'RegisterPresenter.dart';
import 'RegisterProvider.dart';

class RegisterScreen extends StatefulWidget {
  static bool isArabic = true;
  static const String TAG = "/RegisterScreen";

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends BaseState<RegisterScreen, RegisterPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RegisterProvider<LoginResponse> provider = RegisterProvider<LoginResponse>();

  //Rolling listener
  ScrollController _controller = ScrollController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String isoCode, countryCode = '+974';
  String languageSelected = "English";
  int languageSelectedValue = 1;
  bool isError = false;
  String errorMessage;
  Widget myloginWidget;
  int selectedLang;

  @override
  void initState() {
    Prefs.getAppLocal.then((value) => {
          if (value != null)
            {
              setState(() {
                setSelected(value);
                provider.language = value;
              }),
              // provider.isArabic == "ar",
            }
        });

    myloginWidget = DefaultBTN(
      key: Key("ds"),
    );

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      provider.logoOpacity = 1;
      provider.alignmentGeometry = Alignment.center;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<RegisterProvider<LoginResponse>>(
      create: (_) => provider,
      child: Consumer<RegisterProvider<LoginResponse>>(
        builder: (context, provider, _) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 7.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildLogo(context),
                        Gaps.vGap15,
                        Gaps.vGap10,
                        Text(
                          S.current.signUp.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Gaps.vGap8,
                        Text(
                          S.of(context).welcomeToClimizer,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Gaps.vGap30,
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            buildNameField(context),
                            Gaps.vGap10,
                            buildEmailField(context),
                            Gaps.vGap10,
                            buildPhoneField(context),
                            Gaps.vGap10,
                            buildPasswordField(context),
                            Gaps.hGap8,
                            buildConfirmPasswordField(context),
                            Gaps.vGap15,
                            AnimatedOpacity(
                              opacity: provider.opacity,
                              curve: Curves.bounceIn,
                              duration: Duration(seconds: 1),
                              child: Container(
                                width: 100.w,
                                alignment: Alignment.center,
                                child: Text(
                                  provider.errorMessage,
                                  style: TextStyle(fontSize: 10.sp, color: MColors.dart_red),
                                ),
                              ),
                            ),
                            Gaps.vGap15,
                            buildLoginButton(context),
                            SizedBox(
                              height: 1.h,
                            ),
                            buildSignInWith(context),
                          ],
                        ),
                      ),
                    ),
                    Gaps.vGap30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).alreadyHaveAnAccount,
                          style: Theme.of(context).textTheme.titleSmall.copyWith(fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (_) => LoginScreen()));
                          },
                          child: Text(
                            S.of(context).login,
                            style: Theme.of(context).textTheme.titleSmall.copyWith(color:Color(0xff44A4F2),fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLogo(BuildContext context) {
    return Center(
        child: Image.asset(
      ImageUtils.getImagePath("logo"),
      width: 20.w,
      height: 20.w,
    ));
  }

  Widget buildNameField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .01,
          right: MediaQuery.of(context).size.width * .06,
          left: MediaQuery.of(context).size.width * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).name,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            dividerColor: Theme.of(context).dividerColor,
            decoration: InputDecoration(
              hintText: "Name",
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: MTextStyles.textLabelSmall,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
              FilteringTextInputFormatter.allow(RegExp("[ a-zA-Zأ-ي]")),
            ],
            maxLength: 50,
            maxLengthEnforced: false,
            keyboardType: TextInputType.name,
            controller: nameController,
            validator: (name) {
              if (name.isEmpty) {
                return "Name is required";
              }
              return null;
            },
            onSaved: (text) {
              nameController.text = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ],
      ),
    );
  }

  Widget buildEmailField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .01,
          right: MediaQuery.of(context).size.width * .06,
          left: MediaQuery.of(context).size.width * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).emailAddress,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            dividerColor: Theme.of(context).dividerColor,
            decoration: InputDecoration(
              hintText: "Name@mail.com",
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: MTextStyles.textLabelSmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            maxLength: 50,
            maxLengthEnforced: false,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: (email) {
              if (email.isEmpty) {
                return S.of(context).emailisrequired;
              } else if (!Utils.isEmailValid(email)) {
                return S.of(context).emailisnotvalid;
              }
              return null;
            },
            onSaved: (text) {
              emailController.text = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ],
      ),
    );
  }

  Widget buildPhoneField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .01,
          right: MediaQuery.of(context).size.width * .06,
          left: MediaQuery.of(context).size.width * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).phoneNumber,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          IntlPhoneField(
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              hintText: "123456789",
              hintStyle: MTextStyles.textLabelSmall,
              counterText: "",
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
            ),
            showCountryFlag: false,
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            showDropdownIcon: false,
            initialCountryCode: 'AE',
            onChanged: (phone) {
            },
            onCountryChanged: (country) {
            },
          ),
        ],
      ),
    );
  }

  Widget buildPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .014,
          right: MediaQuery.of(context).size.width * .06,
          left: MediaQuery.of(context).size.width * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).password,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            obscureText: provider.obscureTextPassword,
            maxLength: 60,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              hintText: ".........",
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              suffixIcon: GestureDetector(
                  onTap: () {
                    provider.obscureTextPassword = !provider.obscureTextPassword;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      ImageUtils.getSVGPath(provider.obscureTextPassword ?"eye_password" : 'hide_eye'),
                      color: MColors.primary_color,
                    ),
                  )
                  // Icon(_obscureTextPassword ? Icons.visibility : Icons.visibility_off, color: MColors.primary_color),
                  ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: MTextStyles.textLabelSmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            controller: passwordController,
            validator: (text) {
              if (passwordController.text.isEmpty) {
                return S.of(context).passwordisrequired;
              }
              if (passwordController.text.length < 8) {
                return S.of(context).passwordistooshort;
              }
              if (passwordController.text.length > 20) {
                return S.of(context).passwordIsTooLong;
              }
              return null;
            },
            onSaved: (text) {
              passwordController.text = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.done,
            onEditingComplete: () => {
              FocusScope.of(context).unfocus(),
              _submitForm(),
            },
          ),
        ],
      ),
    );
  }

  Widget buildConfirmPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .872,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .014,
          right: MediaQuery.of(context).size.width * .06,
          left: MediaQuery.of(context).size.width * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).confirmPassword,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Gaps.vGap8,
          MyTextFormField(
            obscureText: provider.obscureTextPassword,
            maxLength: 60,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              hintText: ".........",
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              suffixIcon: GestureDetector(
                  onTap: () {
                    provider.obscureTextPassword = !provider.obscureTextPassword;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      ImageUtils.getSVGPath(provider.obscureTextPassword ?"eye_password" : 'hide_eye'),
                      color: MColors.primary_color,
                    ),
                  )
                  // Icon(_obscureTextPassword ? Icons.visibility : Icons.visibility_off, color: MColors.primary_color),
                  ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.outlineBorderLight)),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedErrorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.rejected_color)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: MColors.primary_light_color)),
              counterText: "",
              hintStyle: MTextStyles.textLabelSmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            controller: confirmPasswordController,
            validator: (text) {
              if (confirmPasswordController.text.isEmpty) {
                return S.of(context).passwordisrequired;
              }
              if (confirmPasswordController.text.length < 8) {
                return S.of(context).passwordistooshort;
              }
              if (confirmPasswordController.text.length > 20) {
                return S.of(context).passwordIsTooLong;
              }
              if (confirmPasswordController.text != passwordController.text) {
                return "Password doesn't match";
              }
              return null;
            },
            onSaved: (text) {
              confirmPasswordController.text = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.done,
            onEditingComplete: () => {
              FocusScope.of(context).unfocus(),
              _submitForm(),
            },
          ),
        ],
      ),
    );
  }

  Widget buildSignInWith(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50.sp,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: MColors.gray,
                  width: 2,
                )),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                S.of(context).orRegisterWith,
                style: Theme.of(context).textTheme.titleSmall.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Container(
              width: 50.sp,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: MColors.gray, width: 2)),
              ),
            ),
          ],
        ),
        Gaps.vGap30,
        InkWell(
          onTap: () {},
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: MColors.outlineBorderLight)),
              child: SvgPicture.asset(ImageUtils.getSVGPath("continue_with_google"))),
        ),
      ],
    );
  }

  GestureDetector buildLoginButton(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, animated) => ScaleTransition(
          scale: animated,
          child: child,
        ),
        child: myloginWidget,
      ),
      onTap: () async {
        provider.clearError();
        setState(() {
          myloginWidget = new DefaultBTN(
            key: Key("${Random().nextInt(993)}"),
          );
        });
        FocusScope.of(context).unfocus();
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).enterAllData),
            margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Colors.redAccent[700],
          ));
        }
        _submitForm();
      },
    );
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _doServerLogin();
    }
  }

  Future<void> _doServerLogin() async {
    Map<String, dynamic> bodyParams = new Map();
    bodyParams["name"] = nameController.text;
    bodyParams["email"] = emailController.text;
    bodyParams["mobile"] = phoneNumberController.text;
    bodyParams["password"] = passwordController.text;
    bodyParams["password_confirmation"] = confirmPasswordController.text;
    await mPresenter.doRegisterApiCall(bodyParams);
  }

  @override
  RegisterPresenter createPresenter() {
    return RegisterPresenter();
  }

  @override
  bool get wantKeepAlive => true;


  void setSelected(String s) {
    if (s == 'en' || s == 'null')
      Setting.mobileLanguage.value = new Locale('en');
    else
      Setting.mobileLanguage.value = new Locale('ar');
    Prefs.setAppLocal(s);
    Log.d(s);
  }

  bool checkPlatformIos() {
    return Platform.isIOS;
  }
}

class DefaultBTN extends StatelessWidget {
  const DefaultBTN({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * .06, left: MediaQuery.of(context).size.width * .06),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: MColors.primary_color,
          ),
          child: Center(
            child: Text(
              S.current.signUp.toUpperCase(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ));
  }
}
