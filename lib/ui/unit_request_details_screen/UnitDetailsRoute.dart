import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'UnitDetailsScreen.dart';

class ProfileRouter implements IRouterProvider {
  static String claimsDetailsScreen = UnitRequestDetailsScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(claimsDetailsScreen,
        handler: Handler(handlerFunc: (_, params) => UnitRequestDetailsScreen()));
  }
}
