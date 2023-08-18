import 'package:Cliamizer/res/setting.dart';
import 'package:Cliamizer/route/application.dart';
import 'package:Cliamizer/route/routers.dart';
import 'package:Cliamizer/styles/light_theme_style.dart';
import 'package:Cliamizer/ui/claims_details_screen/ClaimsDetailsProvider.dart';
import 'package:Cliamizer/ui/claims_screen/ClaimsProvider.dart';
import 'package:Cliamizer/ui/edit_profile_screen/EditProfileProvider.dart';
import 'package:Cliamizer/ui/home_screen/HomeProvider.dart';
import 'package:Cliamizer/ui/intro/IntroProvider.dart';
import 'package:Cliamizer/ui/main_screens/MainProvider.dart';
import 'package:Cliamizer/ui/more_screen/MoreProvider.dart';
import 'package:Cliamizer/ui/notification_screen/NotificationProvider.dart';
import 'package:Cliamizer/ui/splash_screen/SplashScreen.dart';
import 'package:Cliamizer/ui/unit_request_details_screen/UnitDetailsProvider.dart';
import 'package:Cliamizer/ui/units_screen/units_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'CommonUtils/LocalNotification.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

// Lisitnening to the background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    LocalNotification.initialize();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification?.title}');
        LocalNotification.createAndDisplayNotification(message);
      }
    });

    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
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
        ChangeNotifierProvider(create: (context) => MoreProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ClaimsProvider()),
        ChangeNotifierProvider(create: (context) => ClaimsDetailsProvider()),
        ChangeNotifierProvider(create: (context) => EditProfileProvider()),
        ChangeNotifierProvider(create: (context) => UnitProvider()),
        ChangeNotifierProvider(create: (context) => UnitDetailsProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: ValueListenableBuilder(
        valueListenable: Setting.mobileLanguage,
        builder: (context, Locale local, _) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return OKToast(
                child: MaterialApp(
                  locale: local,
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
