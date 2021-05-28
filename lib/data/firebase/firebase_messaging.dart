import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterBoilerplateWithMobx/data/sharedpref/shared_preference_helper.dart';
import 'package:flutterBoilerplateWithMobx/models/notifications/received_notification.dart';
import 'package:flutterBoilerplateWithMobx/models/user/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
/// To verify things are working, check out the native platform logs.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

@Singleton()
class FirebaseMessagingHelper {
  // shared pref instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final SharedPreferenceHelper _sharedPrefsHelper;

  IOSInitializationSettings? _initializationSettingsIOS;
  InitializationSettings? _initializationSettings;
  AndroidInitializationSettings _initializationSettingsAndroid =
      AndroidInitializationSettings('ic_notify');
  String? _selectedNotificationPayload;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  FirebaseMessagingHelper(this._sharedPrefsHelper) {
    initNotificationsSettings();
    messaging.getToken().then((token) {
      print("==========================TOKEN=====================\n $token");
      _sharedPrefsHelper.saveFcmToken(token!);
      // }
    });
    _initializationSettings = InitializationSettings(
      android: _initializationSettingsAndroid,
      iOS: _initializationSettingsIOS,
      //macOS: initializationSettingsMacOS
    );
  }

  Future<void> initNotificationsSettings() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  ReceivedNotification? initializationSettingsIOS() {
    try {
      _initializationSettingsIOS = IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification:
              (int? id, String? title, String? body, String? payload) async {
            return ReceivedNotification(
                title: title, body: body, id: id!, payload: payload);
          });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> initializationFlutterLocalNotificationsPlugin() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  String? initializationNotificationSettings() {
    _initializationSettings = InitializationSettings(
      android: _initializationSettingsAndroid,
      iOS: _initializationSettingsIOS,
      //macOS: initializationSettingsMacOS
    );
    flutterLocalNotificationsPlugin.initialize(_initializationSettings!,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
      _selectedNotificationPayload = payload!;
      return payload;
    });
  }
}
