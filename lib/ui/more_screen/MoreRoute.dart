import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'MoreScreen.dart';

class MoreRouter implements IRouterProvider {
  static String moreScreen = MoreScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(moreScreen,
        handler: Handler(handlerFunc: (_, params) => MoreScreen()));
  }
}
