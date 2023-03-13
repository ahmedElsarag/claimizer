import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:Cliamizer/generated/l10n.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SizeConfig2.dart';

class Utils {
  static KeyboardActionsConfig getKeyboardActionsConfig(List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: List.generate(
          list.length,
          (i) => KeyboardActionsItem(
                focusNode: list[i],
              )),
    );
  }

  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  static Future<void> launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }


  static double sWidth(double w, context){
    return MediaQuery.of(context).size.width*(w/100);
  }


  static double sHeight(double h,context){
    return MediaQuery.of(context).size.height*(h/100);
  }
  static double sTextSize(double w, double t,context){
    return kIsWeb?w:t.sp;
  }

  static void showMyDialog(
      BuildContext context, String buttonName, String message,
      {Function callback}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          content: Text(message),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: TextButton(
                    child: Text(buttonName),
                    onPressed: () {
                      Navigator.of(context).pop(); //
                      callback.call(); // dismiss dialog
                    },
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

}

/// 默认dialog背景色为半透明黑色，这里修改源码改为透明
Future<T> showTransparentDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    barrierDismissible: true,
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: const Color(0x00FFFFFF),
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

Future<T> showElasticDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 550),
    transitionBuilder: _buildDialogTransitions,
  );
}

Widget _buildDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: animation.status != AnimationStatus.forward
            ? Curves.easeOutBack
            : ElasticOutCurve(0.85),
      )),
      child: child,
    ),
  );
}
