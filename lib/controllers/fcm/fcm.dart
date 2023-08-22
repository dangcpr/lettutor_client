//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lettutor_client/constants/server.dart';
import 'package:lettutor_client/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCM {
  Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('User granted permission: ${settings.authorizationStatus}');

      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission: ${settings.authorizationStatus}');
        if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
          fcmToken = await messaging.getToken(
            vapidKey: "BJ1lBlvKF3X2dexzJjoKogyDOyXuRoY6Uz00_C8E92SoFJgcvrPu_79xz8SW0yab3bMaL5xnD_u_4oa8Gg0sP3Q",
          );
          debugPrint("FCMWebToken: $fcmToken");
        } else {
          fcmToken = await messaging.getToken();
          await messaging.setAutoInitEnabled(true);
          debugPrint("FCMToken: $fcmToken");
        }

        await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
        
        await messaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
        FirebaseMessaging.onMessage.listen(_firebaseMessagingOnMessageHandler);

      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission: ${settings.authorizationStatus}');

      } else {
        debugPrint('User declined or has not accepted permission: ${settings.authorizationStatus}');
      }
      //FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOnOpenedAppHandler);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/launcher_icon',
        ),
      )
    );
    debugPrint('Handling a background message 1: ${message.notification!.title}');
  }
  else {
    debugPrint('Handling a background message 2: $message');
  }
}

Future<void> _firebaseMessagingOnMessageHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/launcher_icon',
        ),
      )
    );
    debugPrint('Handling on message 1: ${message.notification!.title}');
  }  else {
    debugPrint('Handling on message 2: $message');
  }
}

Future<void> _firebaseMessagingOnOpenedAppHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/launcher_icon',
        ),
      )
    );
    debugPrint('Handling on open App 1: ${message.notification!.title}');
  } else {
    debugPrint('Handling on open App 2: $message');
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();