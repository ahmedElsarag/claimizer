import 'package:fluro/fluro.dart';

import '../../../route/router_init.dart';
import 'EditProfileScreen.dart';

class EditProfileRouter implements IRouterProvider {
  static String editProfileScreen = EditProfileScreen.TAG;

  @override
  void initRouter(FluroRouter router) {
    router.define(editProfileScreen,
        handler: Handler(handlerFunc: (_, params) => EditProfileScreen()));
  }
}
