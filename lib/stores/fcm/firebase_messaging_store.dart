import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterBoilerplateWithMobx/models/notifications/received_notification.dart';
import 'package:flutterBoilerplateWithMobx/utils/services/notifications_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutterBoilerplateWithMobx/data/repository.dart';
import 'package:flutterBoilerplateWithMobx/models/notifications/fcm_notification_model.dart';
import 'package:flutterBoilerplateWithMobx/stores/error/error_store.dart';

part 'firebase_messaging_store.g.dart';

class FirebaseMessagingStore = _FirebaseMessagingStore
    with _$FirebaseMessagingStore;

/// Define a top-level named handler which background/terminated messages will
/// call.
/// To verify things are working, check out the native platform logs.
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

abstract class _FirebaseMessagingStore with Store {
  // repository instance
  late Repository _repository;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  MethodChannel platform =
      MethodChannel('dexterx.dev/flutter_local_notifications_example');

  // constructor:---------------------------------------------------------------
  _FirebaseMessagingStore(Repository repository) {}

  // store variables:-----------------------------------------------------------
  static ObservableFuture<FcmMessage> emptyMessageResponse =
      ObservableFuture<FcmMessage>.value(new FcmMessage());
  static ObservableFuture<ReceivedNotification> emptyReceiveLocalNotification =
      ObservableFuture<ReceivedNotification>.value(
          new ReceivedNotification(title: "", body: "", id: 0, payload: ""));

  @observable
  ObservableFuture<FcmMessage> fetchMessageFuture =
      ObservableFuture<FcmMessage>(emptyMessageResponse);

  @observable
  ObservableFuture<ReceivedNotification> didReceiveLocalNotificationSubject =
      ObservableFuture<ReceivedNotification>(emptyReceiveLocalNotification);
  @observable
  ObservableFuture<String> selectNotificationSubject =
      ObservableFuture<String>.value("");
  @observable
  ObservableFuture<String> sendMessageFuture =
      ObservableFuture<String>.value("");
  @observable
  FcmMessage? _fcmMessage;

  @observable
  String? _selectedNotificationPayload;

  @computed
  bool get loading => fetchMessageFuture.status == FutureStatus.pending;

  @computed
  String get selectedNotificationPayload => _selectedNotificationPayload!;

  // actions:-------------------------------------------------------------------
  @computed
  FcmMessage get fcmMessage => _fcmMessage!;

  @action
  Future<void> initializationSettingsIOS() async {
    if (_repository.initializationSettingsIOS() != null) {
      final future = ObservableFuture<ReceivedNotification>.value(
          _repository.initializationSettingsIOS()!);
      didReceiveLocalNotificationSubject = ObservableFuture(future);
    }
  }

  @action
  Future<void> initializationFlutterLocalNotificationsPlugin() async {
    _repository.initializationFlutterLocalNotificationsPlugin();
  }

  @action
  Future<void> initializationNotificationSettings() async {
    if (_repository.initializationNotificationSettings() != null) {
      final future = ObservableFuture<String>.value(
          _repository.initializationNotificationSettings());
      selectNotificationSubject = ObservableFuture(future);

      future.then((value) {
        print(
            "================LocalNotificationsPlugin   initialize =======:\n ${value}");
      }).catchError((error) {
        //errorStore.errorMessage = DioErrorUtil.handleError(error);
      });
    }
  }

  Future sendAndRetrieveMessage(FcmMessage fcmMessage) async {
    final future = _repository.sendNotification(fcmMessage);
    sendMessageFuture = ObservableFuture(future);

    future.then((message) {
      print(
          "================sendAndRetrieveMessage====ChangeRouteScreen=======:\n ${message}");
    }).catchError((error) {
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
