import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'RegisterScreen.dart';

class RegisterRouter implements IRouterProvider {
  static String registerPage = RegisterScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(registerPage,
        handler: Handler(handlerFunc: (_, params) => RegisterScreen()));
  }
}
