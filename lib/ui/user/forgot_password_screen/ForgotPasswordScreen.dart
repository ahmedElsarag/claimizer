import 'dart:io';
import 'dart:math';
import 'package:Cliamizer/CommonUtils/image_utils.dart';
import 'package:Cliamizer/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Cliamizer/base/view/base_state.dart';
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
import 'ForgotPasswordPresenter.dart';
import 'ForgotPasswordProvider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static bool isArabic = true;
  static const String TAG = "/LoginScreen";

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends BaseState<ForgotPasswordScreen, ForgotPasswordPresenter>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  ForgotPasswordProvider<LoginResponse> provider = ForgotPasswordProvider<LoginResponse>();

  double opacity = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  String  email;

  String languageSelected = "English";
  int languageSelectedValue = 1;
  bool isError = false;
  String errorMessage;
  Widget myloginWidget;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<ForgotPasswordProvider<LoginResponse>>(
      create: (_) => provider,
      child: Consumer<ForgotPasswordProvider<LoginResponse>>(
        builder: (context, provider, _) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        child: SvgPicture.asset(ImageUtils.getSVGPath("back_icon")),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).forgotPasswordTitle,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Gaps.vGap12,
                          SizedBox(
                            width: 65.w,
                            child: Text(
                              S.of(context).enterYourEmailAndInstructionsWillBeSentToYou,
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap50,
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            buildEmailField(context),
                            Gaps.vGap40,
                            buildButton(context),
                          ],
                        ),
                      ),
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

  GestureDetector buildButton(BuildContext context) {
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
        // _submitForm();
      },
    );
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      print('New user saved with signup data:\n');
      print(email );
    }
  }

  Future<void> _doServerLogin(String email, String password) async {
    Map<String, dynamic> bodyParams = new Map();
    bodyParams["email"] = email;
    await mPresenter.doLoginApiCall(bodyParams);
  }

  @override
  ForgotPasswordPresenter createPresenter() {
    return ForgotPasswordPresenter();
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
              S.of(context).sendRequestLink.toUpperCase(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ));
  }
}
