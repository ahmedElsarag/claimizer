import 'package:Cliamizer/ui/claims_screen/claims_screen.dart';
import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';

class NotificationRouter implements IRouterProvider {
  static String claimsScreen = ClaimsScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(claimsScreen,
        handler: Handler(handlerFunc: (_, params) => ClaimsScreen()));
  }
}
