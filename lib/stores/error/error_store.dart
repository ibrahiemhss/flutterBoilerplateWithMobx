import 'package:mobx/mobx.dart';

part 'error_store.g.dart';

class ErrorStore = _ErrorStore with _$ErrorStore;

abstract class _ErrorStore with Store {
  // disposers
  List<ReactionDisposer>? _disposers;

  // constructor:---------------------------------------------------------------
  _ErrorStore() {
    _disposers = [
      reaction((_) => errorTitle, resetErrorTitle, delay: 200),
      reaction((_) => errorMessage, resetErrorMessage, delay: 200),
      reaction((_) => isError, resetIsError, delay: 200),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String errorMessage = '';
  @observable
  String errorTitle = '';
  @observable
  bool isError = false;

  // actions:-------------------------------------------------------------------
  @action
  void setErrorMessage(String title, String message, bool isError) {
    this.errorTitle = title;
    this.errorMessage = message;
    this.isError = isError;
  }

  @action
  void resetErrorMessage(String value) {
    print('calling reset errorMessage');
    this.errorMessage = '';
  }

  @action
  void resetErrorTitle(String value) {
    print('calling reset errorMessage');
    this.errorTitle = '';
  }

  @action
  void resetIsError(bool value) {
    print('calling reset IsErro');
    isError = false;
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    for (final d in _disposers!) {
      d();
    }
  }
}
