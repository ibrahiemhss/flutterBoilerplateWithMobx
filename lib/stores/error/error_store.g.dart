// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ErrorStore on _ErrorStore, Store {
  final _$errorMessageAtom = Atom(name: '_ErrorStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$errorTitleAtom = Atom(name: '_ErrorStore.errorTitle');

  @override
  String get errorTitle {
    _$errorTitleAtom.reportRead();
    return super.errorTitle;
  }

  @override
  set errorTitle(String value) {
    _$errorTitleAtom.reportWrite(value, super.errorTitle, () {
      super.errorTitle = value;
    });
  }

  final _$isErrorAtom = Atom(name: '_ErrorStore.isError');

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  final _$_ErrorStoreActionController = ActionController(name: '_ErrorStore');

  @override
  void setErrorMessage(String title, String message, bool isError) {
    final _$actionInfo = _$_ErrorStoreActionController.startAction(
        name: '_ErrorStore.setErrorMessage');
    try {
      return super.setErrorMessage(title, message, isError);
    } finally {
      _$_ErrorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrorMessage(String value) {
    final _$actionInfo = _$_ErrorStoreActionController.startAction(
        name: '_ErrorStore.resetErrorMessage');
    try {
      return super.resetErrorMessage(value);
    } finally {
      _$_ErrorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrorTitle(String value) {
    final _$actionInfo = _$_ErrorStoreActionController.startAction(
        name: '_ErrorStore.resetErrorTitle');
    try {
      return super.resetErrorTitle(value);
    } finally {
      _$_ErrorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetIsError(bool value) {
    final _$actionInfo = _$_ErrorStoreActionController.startAction(
        name: '_ErrorStore.resetIsError');
    try {
      return super.resetIsError(value);
    } finally {
      _$_ErrorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo =
        _$_ErrorStoreActionController.startAction(name: '_ErrorStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_ErrorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
errorTitle: ${errorTitle},
isError: ${isError}
    ''';
  }
}
