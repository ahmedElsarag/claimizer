import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'NotificationScreen.dart';

class NotificationRouter implements IRouterProvider {
  static String notificationScreen = NotificationScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(notificationScreen,
        handler: Handler(handlerFunc: (_, params) => NotificationScreen()));
  }
}
