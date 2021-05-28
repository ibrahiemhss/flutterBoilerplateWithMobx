// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ChatStore.loading'))
      .value;
  Computed<bool>? _$loadingListMessagComputed;

  @override
  bool get loadingListMessag => (_$loadingListMessagComputed ??= Computed<bool>(
          () => super.loadingListMessag,
          name: '_ChatStore.loadingListMessag'))
      .value;
  Computed<bool>? _$successFetchMessageComputed;

  @override
  bool get successFetchMessage => (_$successFetchMessageComputed ??=
          Computed<bool>(() => super.successFetchMessage,
              name: '_ChatStore.successFetchMessage'))
      .value;
  Computed<int>? _$messageIndexComputed;

  @override
  int get messageIndex =>
      (_$messageIndexComputed ??= Computed<int>(() => super.messageIndex,
              name: '_ChatStore.messageIndex'))
          .value;
  Computed<List<MessageModel>>? _$messagesWidgetsComputed;

  @override
  List<MessageModel> get messagesWidgets => (_$messagesWidgetsComputed ??=
          Computed<List<MessageModel>>(() => super.messagesWidgets,
              name: '_ChatStore.messagesWidgets'))
      .value;

  final _$fetchMessageFutureAtom = Atom(name: '_ChatStore.fetchMessageFuture');

  @override
  ObservableFuture<String> get fetchMessageFuture {
    _$fetchMessageFutureAtom.reportRead();
    return super.fetchMessageFuture;
  }

  @override
  set fetchMessageFuture(ObservableFuture<String> value) {
    _$fetchMessageFutureAtom.reportWrite(value, super.fetchMessageFuture, () {
      super.fetchMessageFuture = value;
    });
  }

  final _$fetchListMessageFutureAtom =
      Atom(name: '_ChatStore.fetchListMessageFuture');

  @override
  ObservableFuture<List<MessageModel>> get fetchListMessageFuture {
    _$fetchListMessageFutureAtom.reportRead();
    return super.fetchListMessageFuture;
  }

  @override
  set fetchListMessageFuture(ObservableFuture<List<MessageModel>> value) {
    _$fetchListMessageFutureAtom
        .reportWrite(value, super.fetchListMessageFuture, () {
      super.fetchListMessageFuture = value;
    });
  }

  final _$messageAtom = Atom(name: '_ChatStore.message');

  @override
  String? get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String? value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$_messageIndexAtom = Atom(name: '_ChatStore._messageIndex');

  @override
  int get _messageIndex {
    _$_messageIndexAtom.reportRead();
    return super._messageIndex;
  }

  @override
  set _messageIndex(int value) {
    _$_messageIndexAtom.reportWrite(value, super._messageIndex, () {
      super._messageIndex = value;
    });
  }

  final _$_successFetchMessageAtom =
      Atom(name: '_ChatStore._successFetchMessage');

  @override
  bool get _successFetchMessage {
    _$_successFetchMessageAtom.reportRead();
    return super._successFetchMessage;
  }

  @override
  set _successFetchMessage(bool value) {
    _$_successFetchMessageAtom.reportWrite(value, super._successFetchMessage,
        () {
      super._successFetchMessage = value;
    });
  }

  final _$_messagesWidgetsAtom = Atom(name: '_ChatStore._messagesWidgets');

  @override
  List<MessageModel> get _messagesWidgets {
    _$_messagesWidgetsAtom.reportRead();
    return super._messagesWidgets;
  }

  @override
  set _messagesWidgets(List<MessageModel> value) {
    _$_messagesWidgetsAtom.reportWrite(value, super._messagesWidgets, () {
      super._messagesWidgets = value;
    });
  }

  final _$setFetchMessageAsyncAction =
      AsyncAction('_ChatStore.setFetchMessage');

  @override
  Future<dynamic> setFetchMessage(bool val) {
    return _$setFetchMessageAsyncAction.run(() => super.setFetchMessage(val));
  }

  final _$setMessageIndexAsyncAction =
      AsyncAction('_ChatStore.setMessageIndex');

  @override
  Future<dynamic> setMessageIndex(int val) {
    return _$setMessageIndexAsyncAction.run(() => super.setMessageIndex(val));
  }

  final _$insertMessageAsyncAction = AsyncAction('_ChatStore.insertMessage');

  @override
  Future<dynamic> insertMessage(dynamic val) {
    return _$insertMessageAsyncAction.run(() => super.insertMessage(val));
  }

  final _$_ChatStoreActionController = ActionController(name: '_ChatStore');

  @override
  void resetListWidget(dynamic list) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.resetListWidget');
    try {
      return super.resetListWidget(list);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo =
        _$_ChatStoreActionController.startAction(name: '_ChatStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchMessageFuture: ${fetchMessageFuture},
fetchListMessageFuture: ${fetchListMessageFuture},
message: ${message},
loading: ${loading},
loadingListMessag: ${loadingListMessag},
successFetchMessage: ${successFetchMessage},
messageIndex: ${messageIndex},
messagesWidgets: ${messagesWidgets}
    ''';
  }
}
