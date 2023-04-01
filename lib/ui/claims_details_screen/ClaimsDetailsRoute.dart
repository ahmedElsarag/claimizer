import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'ClaimsDetailsScreen.dart';

class ProfileRouter implements IRouterProvider {
  static String claimsDetailsScreen = ClaimsDetailsScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(claimsDetailsScreen,
        handler: Handler(handlerFunc: (_, params) => ClaimsDetailsScreen()));
  }
}
