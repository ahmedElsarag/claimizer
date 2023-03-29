import 'dart:io';
import 'dart:math';

import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/base/view/base_state.dart';
import 'package:Cliamizer/res/gaps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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
import '../../../res/styles.dart';
import '../forgot_password_screen/ForgotPasswordScreen.dart';
import '../register_screen/RegisterScreen.dart';
import 'LoginPresenter.dart';
import 'LoginProvider.dart';

class LoginScreen extends StatefulWidget {
  static bool isArabic = true;
  static const String TAG = "/LoginScreen";

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BaseState<LoginScreen, LoginPresenter> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  LoginProvider<LoginResponse> provider = LoginProvider<LoginResponse>();

  //Rolling listener
  ScrollController _controller = ScrollController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String password, email;

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
                print('###### $value');
                provider.language = value;
              }),
              // provider.isArabic == "ar",
            }
        });

    myloginWidget = LoginBTN(
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
    return ChangeNotifierProvider<LoginProvider<LoginResponse>>(
      create: (_) => provider,
      child: Consumer<LoginProvider<LoginResponse>>(
        builder: (context, provider, _) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 7.h),
                    buildLogo(context),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.current.login.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Gaps.vGap8,
                        Text(
                          S.of(context).welcomeBackToClimizer,
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
                            buildEmailField(context),
                            Gaps.vGap10,
                            buildPasswordField(context),
                            Gaps.hGap8,
                            Container(
                              width: 100.w,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: provider.isRememberMe,
                                      onChanged: (value) {
                                        provider.isRememberMe = !provider.isRememberMe;
                                      }),
                                  Text(
                                    S.of(context).rememberMe,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context, CupertinoPageRoute(builder: (_) => ForgotPasswordScreen()));
                                    },
                                    child: Text(
                                      S.of(context).forgotPassword,
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.vGap12,
                            AnimatedOpacity(
                              opacity: provider.opacity,
                              curve: Curves.bounceIn,
                              duration: Duration(seconds: 1),
                              child: Container(
                                width: 100.w,
                                margin: EdgeInsets.only(left:6.w,right:6.w
                                    ,bottom: 15),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Color(0xffDA1414).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                child: Text(
                                  provider.errorMessage,
                                  style:  MTextStyles.textMain14,
                                ),
                              ),
                            ),
                            buildLoginButton(context),
                            SizedBox(
                              height: 4.h,
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
                          S.of(context).dontHaveAnAccount,
                          style: Theme.of(context).textTheme.titleSmall.copyWith(fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (_) => RegisterScreen()));
                          },
                          child: Text(
                            S.of(context).signUp,
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
      width: 18.w,
      height: 18.w,
    ));
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
          Gaps.vGap12,
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
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            maxLength: 50,
            maxLengthEnforced: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: email,
            validator: (email) {
              if (email.isEmpty) {
                return S.of(context).emailisrequired;
              } else if (!Utils.isEmailValid(email)) {
                return S.of(context).emailisnotvalid;
              }
              return null;
            },
            onSaved: (text) {
              email = text;
            },
            autofocus: false,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
          Gaps.vGap12,
          MyTextFormField(
            obscureText: provider.obscureTextPassword,
            maxLength: 60,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              errorStyle: Theme.of(context).textTheme.bodySmall.copyWith(color: Colors.redAccent),
              hintText: "password",
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              suffixIcon: GestureDetector(
                  onTap: () {
                    provider.obscureTextPassword = !provider.obscureTextPassword;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(
                      ImageUtils.getSVGPath(provider.obscureTextPassword ? "eye_password" : 'hide_eye'),
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
              hintStyle: Theme.of(context).textTheme.displaySmall,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            initialValue: password,
            validator: (text) {
              if (text.isEmpty) {
                return S.of(context).passwordisrequired;
              }
              // if (text.length < 8) {
              //   return S.of(context).passwordistooshort;
              // }
              // if (text.length > 20) {
              //   return S.of(context).passwordIsTooLong;
              // }
              return null;
            },
            onSaved: (text) {
              password = text;
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
              width: 28.w,
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
              width: 28.w,
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
          myloginWidget = new LoginBTN(
            key: Key("${Random().nextInt(993)}"),
          );
        });
        FocusScope.of(context).unfocus();
        _submitForm();
      },
    );
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      print('New user saved with signup data:\n');
      print(email + " " + password);
      _doServerLogin(email, password);
    }
  }

  Future<void> _doServerLogin(String email, String password) async {
    Map<String, dynamic> bodyParams = new Map();
    bodyParams["email"] = email;
    bodyParams["password"] = password;
    await mPresenter.doLoginApiCall(bodyParams);
  }

  @override
  LoginPresenter createPresenter() {
    return LoginPresenter();
  }

  @override
  bool get wantKeepAlive => true;

  void _refresh() {
    setState(() {
      isError = false;
    });
  }

  void setSelected(String s) {
    if (s == 'en' || s == 'null')
      Setting.mobileLanguage.value = new Locale('en');
    else
      Setting.mobileLanguage.value = new Locale('ar');
    Prefs.setAppLocal(s);
    Log.d(s);
  }

  void setError(String message, bool isErrors) {
    setState(() {
      isError = isErrors;
      errorMessage = message;
    });
  }

  bool checkPlatformIos() {
    return Platform.isIOS;
  }
}

class LoginBTN extends StatelessWidget {
  const LoginBTN({
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
              S.current.login.toUpperCase(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ));
  }
}
