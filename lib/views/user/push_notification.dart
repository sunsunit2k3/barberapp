import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future init() async {
    // Request permissions for iOS
    await _firebaseMessaging.requestPermission(
      announcement: true,
      alert: true,
      carPlay: false,
      criticalAlert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    // Get the token
    final token = await _firebaseMessaging.getToken();
    // print('Token: $token');
  }

  static Future locaNotiInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
      macOS: null,
    );
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
      onDidReceiveNotificationResponse: onNotificationTap,
    );
  }

  static void onNotificationTap(NotificationResponse response) {
    // print('onNotificationTap: $message');
  }
}
