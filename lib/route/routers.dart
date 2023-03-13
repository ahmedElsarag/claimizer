import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/widgets.dart';
import 'package:Cliamizer/route/router_init.dart';

class Routes {
  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint("debugPrint");
      return Container();
    });


    _listRouter.clear();
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
