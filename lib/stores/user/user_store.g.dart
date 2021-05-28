// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<String>? _$fcmTokenComputed;

  @override
  String get fcmToken => (_$fcmTokenComputed ??=
          Computed<String>(() => super.fcmToken, name: '_UserStore.fcmToken'))
      .value;
  Computed<bool>? _$loadingDataComputed;

  @override
  bool get loadingData =>
      (_$loadingDataComputed ??= Computed<bool>(() => super.loadingData,
              name: '_UserStore.loadingData'))
          .value;
  Computed<UserModel>? _$userModelComputed;

  @override
  UserModel get userModel =>
      (_$userModelComputed ??= Computed<UserModel>(() => super.userModel,
              name: '_UserStore.userModel'))
          .value;
  Computed<int>? _$userTypeComputed;

  @override
  int get userType => (_$userTypeComputed ??=
          Computed<int>(() => super.userType, name: '_UserStore.userType'))
      .value;
  Computed<bool>? _$successLogInComputed;

  @override
  bool get successLogIn =>
      (_$successLogInComputed ??= Computed<bool>(() => super.successLogIn,
              name: '_UserStore.successLogIn'))
          .value;
  Computed<bool>? _$successLogoutComputed;

  @override
  bool get successLogout =>
      (_$successLogoutComputed ??= Computed<bool>(() => super.successLogout,
              name: '_UserStore.successLogout'))
          .value;
  Computed<bool>? _$successRegistrationComputed;

  @override
  bool get successRegistration => (_$successRegistrationComputed ??=
          Computed<bool>(() => super.successRegistration,
              name: '_UserStore.successRegistration'))
      .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;

  final _$successAtom = Atom(name: '_UserStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$loginFutureAtom = Atom(name: '_UserStore.loginFuture');

  @override
  ObservableFuture<bool> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<bool> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  final _$_userModelAtom = Atom(name: '_UserStore._userModel');

  @override
  UserModel? get _userModel {
    _$_userModelAtom.reportRead();
    return super._userModel;
  }

  @override
  set _userModel(UserModel? value) {
    _$_userModelAtom.reportWrite(value, super._userModel, () {
      super._userModel = value;
    });
  }

  final _$_userTypeAtom = Atom(name: '_UserStore._userType');

  @override
  int? get _userType {
    _$_userTypeAtom.reportRead();
    return super._userType;
  }

  @override
  set _userType(int? value) {
    _$_userTypeAtom.reportWrite(value, super._userType, () {
      super._userType = value;
    });
  }

  final _$_fcmMessageAtom = Atom(name: '_UserStore._fcmMessage');

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

  final _$_successLogInAtom = Atom(name: '_UserStore._successLogIn');

  @override
  bool get _successLogIn {
    _$_successLogInAtom.reportRead();
    return super._successLogIn;
  }

  @override
  set _successLogIn(bool value) {
    _$_successLogInAtom.reportWrite(value, super._successLogIn, () {
      super._successLogIn = value;
    });
  }

  final _$_successLogoutAtom = Atom(name: '_UserStore._successLogout');

  @override
  bool get _successLogout {
    _$_successLogoutAtom.reportRead();
    return super._successLogout;
  }

  @override
  set _successLogout(bool value) {
    _$_successLogoutAtom.reportWrite(value, super._successLogout, () {
      super._successLogout = value;
    });
  }

  final _$_successRegistrationAtom =
      Atom(name: '_UserStore._successRegistration');

  @override
  bool get _successRegistration {
    _$_successRegistrationAtom.reportRead();
    return super._successRegistration;
  }

  @override
  set _successRegistration(bool value) {
    _$_successRegistrationAtom.reportWrite(value, super._successRegistration,
        () {
      super._successRegistration = value;
    });
  }

  final _$_loadingDataAtom = Atom(name: '_UserStore._loadingData');

  @override
  bool get _loadingData {
    _$_loadingDataAtom.reportRead();
    return super._loadingData;
  }

  @override
  set _loadingData(bool value) {
    _$_loadingDataAtom.reportWrite(value, super._loadingData, () {
      super._loadingData = value;
    });
  }

  final _$_fcmTokenAtom = Atom(name: '_UserStore._fcmToken');

  @override
  String get _fcmToken {
    _$_fcmTokenAtom.reportRead();
    return super._fcmToken;
  }

  @override
  set _fcmToken(String value) {
    _$_fcmTokenAtom.reportWrite(value, super._fcmToken, () {
      super._fcmToken = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$saveUserAsyncAction = AsyncAction('_UserStore.saveUser');

  @override
  Future<dynamic> saveUser(UserModel userModel) {
    return _$saveUserAsyncAction.run(() => super.saveUser(userModel));
  }

  final _$checkUserFoundAsyncAction = AsyncAction('_UserStore.checkUserFound');

  @override
  Future<void> checkUserFound(UserModel userModel) {
    return _$checkUserFoundAsyncAction
        .run(() => super.checkUserFound(userModel));
  }

  final _$getUserDataAsyncAction = AsyncAction('_UserStore.getUserData');

  @override
  Future<dynamic> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void resetSuccessLogIn(bool value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.resetSuccessLogIn');
    try {
      return super.resetSuccessLogIn(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetSuccessRegistration(bool value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.resetSuccessRegistration');
    try {
      return super.resetSuccessRegistration(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetSuccessLogout(bool value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.resetSuccessLogout');
    try {
      return super.resetSuccessLogout(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic logout() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.logout');
    try {
      return super.logout();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
loginFuture: ${loginFuture},
fcmToken: ${fcmToken},
loadingData: ${loadingData},
userModel: ${userModel},
userType: ${userType},
successLogIn: ${successLogIn},
successLogout: ${successLogout},
successRegistration: ${successRegistration},
isLoading: ${isLoading}
    ''';
  }
}
