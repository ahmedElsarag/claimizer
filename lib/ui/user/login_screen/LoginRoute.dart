import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'LoginScreen.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = LoginScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, params) => LoginScreen()));
  }
}
