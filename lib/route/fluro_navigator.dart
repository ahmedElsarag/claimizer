import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'application.dart';

/// Fluro Routing
class NavigatorUtils {
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native);
  }

  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((result) {
      // Page back result for null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  /// return
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// Return with parameters
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

}
