import 'package:barberapp/firebase_options.dart';
import 'package:barberapp/models/user_model.dart';
import 'package:barberapp/views/admin/admin_screem.dart';
import 'package:barberapp/views/onboarding.dart';
import 'package:barberapp/views/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('Message: ${message.notification!.title}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotification.init();
  PushNotification.locaNotiInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserModel user = UserModel(
      id: '1',
      name: 'Admin',
      email: 'admin@gmail.com',
      role: 'admin',
      image: 'assets/images/user.png');

  // This widget is the root of your application.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WrapperAdmin(user: user),
    );
  }
}
