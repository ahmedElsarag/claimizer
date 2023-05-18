import 'package:Cliamizer/res/colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_utils.dart';

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
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
  }

  String convertDateFormat(String originalDateString) {
    DateTime originalDate = DateTime.parse(originalDateString.replaceAll('/', '-'));
    String newDateString =
        '${originalDate.day.toString().padLeft(2, '0')}-${originalDate.month.toString().padLeft(2, '0')}-${originalDate.year}';
    return newDateString;
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

  static double sWidth(double w, context) {
    return MediaQuery.of(context).size.width * (w / 100);
  }

  static double sHeight(double h, context) {
    return MediaQuery.of(context).size.height * (h / 100);
  }

  static double sTextSize(double w, double t, context) {
    return kIsWeb ? w : t.sp;
  }

  static void showMyDialog(BuildContext context, String buttonName, String message, {Function callback}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
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

  static Color getStatusTypeBGColorFromString(String status) {
    switch (status) {
      case 'pending':
      case 'in_progress':
      case 'Late':
      case 'draft':
      case 'warning':
        return const Color(0xffffcc00);
      case 'accepted':
      case 'Present':
      case 'finished':
      case 'success':
      case 'start':
        return const Color(0xffff9966);
      case 'rejected':
      case 'refused':
      case 'canceled':
      case 'cancelled':
      case 'error':
        return MColors.error_color;
      default:
        return MColors.textFieldBorder;
    }
  }

  static Color getStatusTypeColorFromString(String status) {
    switch (status) {
      case 'pending':
      case 'in_progress':
      case 'Late':
      case 'draft':
      case 'warning':
        return MColors.text_dark;
      case 'accepted':
      case 'Present':
      case 'finished':
      case 'success':
      case 'start':
        return MColors.text_dark;
      case 'rejected':
      case 'refused':
      case 'canceled':
      case 'cancelled':
      case 'error':
        return MColors.white;
      default:
        return MColors.black;
    }
  }

  static Widget getStatusTypeIconFromString(String status) {
    switch (status) {
      case 'pending':
      case 'in_progress':
      case 'Late':
      case 'draft':
      case 'warning':
        return Icon(
          Icons.warning_amber_rounded,
          color: getStatusTypeColorFromString(status),
          size: 28.sp,
        );
      case 'accepted':
      case 'Present':
      case 'finished':
      case 'success':
      case 'start':
        return Icon(
          Icons.done_all_rounded,
          color: getStatusTypeColorFromString(status),
          size: 28.sp,
        );
      case 'rejected':
      case 'refused':
      case 'canceled':
      case 'cancelled':
      case 'error':
        return Icon(
          Icons.error_outline_rounded,
          color: getStatusTypeColorFromString(status),
          size: 28.sp,
        );
      default:
        return Image.asset(
          ImageUtils.getImagePath("logo"),
          width: 12.w,
          height: 12.w,
        );
    }
  }

  static Color getClaimStatusColorFromString(String status) {
    switch (status) {
      case 'New':
      case 'new':
      case 'جديد':
        return Color(0xffff9500);
      case 'Assigned':
      case 'assigned':
      case 'تم اختيار فني':
      case 'Renewing':
      case 'renewing':
      case 'Active':
      case 'active':
        return Color.fromRGBO(45, 11, 238, 0.95);
      case 'Started':
      case 'started':
      case 'بدأت':
        return Color(0xff10d2c8);
      case 'Completed':
      case 'completed':
      case 'مكتمل':
        return Color(0xff679c0d);
      case 'Closed':
      case 'closed':
      case 'مغلق':
        return Color(0xff0a562e);
      case 'Cancelled':
      case 'cancelled':
      case 'ملغي':
        return Color(0xffff0000);
      default:
        return Color(0xff44A4F2).withOpacity(0.08);
    }
  }

  static Color getUnitStatusColorFromString(String status) {
    switch (status) {
      case 'New':
      case 'new':
      case 'جديد':
        return Color(0xffff9500);
      case 'Assigned':
      case 'assigned':
      case 'تم اختيار فني':
      case 'Renewing':
      case 'Renewed':
      case 'renewing':
      case 'مجدد':
      case 'Active':
      case 'active':
        return Color.fromRGBO(45, 11, 238, 0.95);
      case 'Started':
      case 'started':
      case 'بدأت':
        return Color(0xff10d2c8);
      case 'Completed':
      case 'completed':
      case 'مكتمل':
        return Color(0xff679c0d);
      case 'Closed':
      case 'closed':
      case 'مغلق':
        return Color(0xff0a562e);
      case 'Cancelled':
      case 'cancelled':
      case 'ملغي':
      case 'Rejected':
      case 'rejected':
      case 'مرفوض':
        return Color(0xffff0000);
      default:
        return Color(0xff44A4F2).withOpacity(0.08);
    }
  }

  static Color getTextStatusColorFromString(String status) {
    switch (status) {
      case 'New':
      case 'new':
      case 'جديد':
      case 'Assigned':
      case 'assigned':
      case 'تم اختيار فني':
      case 'Completed':
      case 'completed':
      case 'مكتمل':
      case 'Closed':
      case 'closed':
      case 'مغلق':
      case 'Cancelled':
      case 'cancelled':
      case 'Canceled':
      case 'canceled':
      case 'Renewing':
      case 'Renewed':
      case 'مجدد':
      case 'renewing':
      case 'ملغي':
      case 'Rejected':
      case 'rejected':
      case 'مرفوض':
      case 'Active':
      case 'active':
        return Colors.white;
      case 'Started':
      case 'started':
      case 'بدأت':
      case 'Approved':
      case 'approved':
      case 'موافق عليه':
      case 'Finished':
      case 'finished':
      case 'منتهي':
      case 'مرفوض':
        return MColors.text_button_color;
      default:
        return Color(0xff44A4F2).withOpacity(0.08);
    }
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
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
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
    BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
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
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null ? Theme(data: theme, child: pageChild) : pageChild;
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
    BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(CurvedAnimation(
        parent: animation,
        curve: animation.status != AnimationStatus.forward ? Curves.easeOutBack : ElasticOutCurve(0.85),
      )),
      child: child,
    ),
  );
}
