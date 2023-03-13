import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'ForgotPasswordScreen.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = ForgotPasswordScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, params) => ForgotPasswordScreen()));
  }
}
