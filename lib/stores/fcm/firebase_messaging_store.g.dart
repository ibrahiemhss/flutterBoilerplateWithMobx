// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_messaging_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FirebaseMessagingStore on _FirebaseMessagingStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_FirebaseMessagingStore.loading'))
      .value;
  Computed<String>? _$selectedNotificationPayloadComputed;

  @override
  String get selectedNotificationPayload =>
      (_$selectedNotificationPayloadComputed ??= Computed<String>(
              () => super.selectedNotificationPayload,
              name: '_FirebaseMessagingStore.selectedNotificationPayload'))
          .value;
  Computed<FcmMessage>? _$fcmMessageComputed;

  @override
  FcmMessage get fcmMessage =>
      (_$fcmMessageComputed ??= Computed<FcmMessage>(() => super.fcmMessage,
              name: '_FirebaseMessagingStore.fcmMessage'))
          .value;

  final _$fetchMessageFutureAtom =
      Atom(name: '_FirebaseMessagingStore.fetchMessageFuture');

  @override
  ObservableFuture<FcmMessage> get fetchMessageFuture {
    _$fetchMessageFutureAtom.reportRead();
    return super.fetchMessageFuture;
  }

  @override
  set fetchMessageFuture(ObservableFuture<FcmMessage> value) {
    _$fetchMessageFutureAtom.reportWrite(value, super.fetchMessageFuture, () {
      super.fetchMessageFuture = value;
    });
  }

  final _$didReceiveLocalNotificationSubjectAtom =
      Atom(name: '_FirebaseMessagingStore.didReceiveLocalNotificationSubject');

  @override
  ObservableFuture<ReceivedNotification>
      get didReceiveLocalNotificationSubject {
    _$didReceiveLocalNotificationSubjectAtom.reportRead();
    return super.didReceiveLocalNotificationSubject;
  }

  @override
  set didReceiveLocalNotificationSubject(
      ObservableFuture<ReceivedNotification> value) {
    _$didReceiveLocalNotificationSubjectAtom
        .reportWrite(value, super.didReceiveLocalNotificationSubject, () {
      super.didReceiveLocalNotificationSubject = value;
    });
  }

  final _$selectNotificationSubjectAtom =
      Atom(name: '_FirebaseMessagingStore.selectNotificationSubject');

  @override
  ObservableFuture<String> get selectNotificationSubject {
    _$selectNotificationSubjectAtom.reportRead();
    return super.selectNotificationSubject;
  }

  @override
  set selectNotificationSubject(ObservableFuture<String> value) {
    _$selectNotificationSubjectAtom
        .reportWrite(value, super.selectNotificationSubject, () {
      super.selectNotificationSubject = value;
    });
  }

  final _$sendMessageFutureAtom =
      Atom(name: '_FirebaseMessagingStore.sendMessageFuture');

  @override
  ObservableFuture<String> get sendMessageFuture {
    _$sendMessageFutureAtom.reportRead();
    return super.sendMessageFuture;
  }

  @override
  set sendMessageFuture(ObservableFuture<String> value) {
    _$sendMessageFutureAtom.reportWrite(value, super.sendMessageFuture, () {
      super.sendMessageFuture = value;
    });
  }

  final _$_fcmMessageAtom = Atom(name: '_FirebaseMessagingStore._fcmMessage');

  @override
  FcmMessage? get _fcmMessage {
    _$_fcmMessageAtom.reportRead();
    return super._fcmMessage;
  }

  @override
  set _fcmMessage(FcmMessage? value) {
    _$_fcmMessageAtom.reportWrite(value, super._fcmMessage, () {
      super._fcmMessage = value;
    });
  }

  final _$_selectedNotificationPayloadAtom =
      Atom(name: '_FirebaseMessagingStore._selectedNotificationPayload');

  @override
  String? get _selectedNotificationPayload {
    _$_selectedNotificationPayloadAtom.reportRead();
    return super._selectedNotificationPayload;
  }

  @override
  set _selectedNotificationPayload(String? value) {
    _$_selectedNotificationPayloadAtom
        .reportWrite(value, super._selectedNotificationPayload, () {
      super._selectedNotificationPayload = value;
    });
  }

  final _$initializationSettingsIOSAsyncAction =
      AsyncAction('_FirebaseMessagingStore.initializationSettingsIOS');

  @override
  Future<void> initializationSettingsIOS() {
    return _$initializationSettingsIOSAsyncAction
        .run(() => super.initializationSettingsIOS());
  }

  final _$initializationFlutterLocalNotificationsPluginAsyncAction = AsyncAction(
      '_FirebaseMessagingStore.initializationFlutterLocalNotificationsPlugin');

  @override
  Future<void> initializationFlutterLocalNotificationsPlugin() {
    return _$initializationFlutterLocalNotificationsPluginAsyncAction
        .run(() => super.initializationFlutterLocalNotificationsPlugin());
  }

  final _$initializationNotificationSettingsAsyncAction =
      AsyncAction('_FirebaseMessagingStore.initializationNotificationSettings');

  @override
  Future<void> initializationNotificationSettings() {
    return _$initializationNotificationSettingsAsyncAction
        .run(() => super.initializationNotificationSettings());
  }

  @override
  String toString() {
    return '''
fetchMessageFuture: ${fetchMessageFuture},
didReceiveLocalNotificationSubject: ${didReceiveLocalNotificationSubject},
selectNotificationSubject: ${selectNotificationSubject},
sendMessageFuture: ${sendMessageFuture},
loading: ${loading},
selectedNotificationPayload: ${selectedNotificationPayload},
fcmMessage: ${fcmMessage}
    ''';
  }
}
