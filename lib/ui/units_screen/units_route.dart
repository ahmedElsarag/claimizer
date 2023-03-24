import 'package:Cliamizer/ui/claims_screen/claims_screen.dart';
import 'package:Cliamizer/ui/units_screen/units_screen.dart';
import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';

class UnitsRouter implements IRouterProvider {
  static String unitScreen = UnitsScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(unitScreen,
        handler: Handler(handlerFunc: (_, params) => ClaimsScreen()));
  }
}
