import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher_foreground"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
    );
  }


  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "1",
          "pushnotificationapp",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,

        payload: message.data['id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

}