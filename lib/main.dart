import 'package:Cliamizer/res/setting.dart';
import 'package:Cliamizer/route/application.dart';
import 'package:Cliamizer/route/routers.dart';
import 'package:Cliamizer/styles/light_theme_style.dart';
import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsProvider.dart';
import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsScreen.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/home_screen/HomeProvider.dart';
import 'package:Cliamizer/ui/intro/IntroProvider.dart';
import 'package:Cliamizer/ui/main_screens/MainProvider.dart';
import 'package:Cliamizer/ui/notification_screen/NotificationProvider.dart';
import 'package:Cliamizer/ui/splash_screen/SplashScreen.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'CommonUtils/LanguageProvider.dart';
import 'generated/l10n.dart';

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkVersion = androidInfo.version.sdkInt ?? 0;
    final androidOverscrollIndicator = sdkVersion > 30 ? AndroidOverscrollIndicator.stretch : AndroidOverscrollIndicator.glow;
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IntroProvider()),
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ClaimsProvider()),
        ChangeNotifierProvider(create: (context) => ClaimsDetailsProvider()),
        ChangeNotifierProvider(create: (context) => UnitProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: ValueListenableBuilder(
        valueListenable: Setting.mobileLanguage,
        builder: (context, Locale local, _) {
          final languageProvider = Provider.of<LanguageProvider>(context);
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                locale: languageProvider.locale,
                localizationsDelegates: [
                  S.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                title: "Claimizer",
                theme: LightStyles.lightTheme(context),
                home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
