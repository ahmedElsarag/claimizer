import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'ProfileScreen.dart';

class ProfileRouter implements IRouterProvider {
  static String profileScreen = ProfileScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(profileScreen,
        handler: Handler(handlerFunc: (_, params) => ProfileScreen()));
  }
}
