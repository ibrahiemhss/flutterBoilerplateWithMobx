import 'package:flutterBoilerplateWithMobx/data/repository.dart';
import 'package:flutterBoilerplateWithMobx/models/message/message_model.dart';
import 'package:flutterBoilerplateWithMobx/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  // repository instance
  Repository? _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
// disposers
  List<ReactionDisposer>? _disposers;

  // constructor:---------------------------------------------------------------
  _ChatStore(Repository? repository) {
    this._repository = repository;
    _disposers = [
      //reaction((_) => fetchListMessageFuture, resetListWidget, delay: 200),
    ];
  }

  // actions:-------------------------------------------------------------------
  @action
  void resetListWidget(list) {
    print('calling reset resetListWidget');
    fetchListMessageFuture = ObservableFuture<List<MessageModel>>.value([]);
    _messagesWidgets = <MessageModel>[];
    setFetchMessage(false);
  }

  // store variables:-----------------------------------------------------------
  static late final ObservableFuture<String> emptyMessageResponse =
      ObservableFuture<String>.value("");

  @observable
  late ObservableFuture<String> fetchMessageFuture =
      ObservableFuture<String>(emptyMessageResponse);

  @observable
  late ObservableFuture<List<MessageModel>> fetchListMessageFuture =
      ObservableFuture<List<MessageModel>>.value([]);

  @observable
  String? message;

  @observable
  int _messageIndex = 0;

  @observable
  bool _successFetchMessage = false;
  @observable
  List<MessageModel> _messagesWidgets = <MessageModel>[];

  @computed
  bool get loading => fetchMessageFuture.status == FutureStatus.pending;

  @computed
  bool get loadingListMessag =>
      fetchListMessageFuture.status == FutureStatus.pending;

  @computed
  bool get successFetchMessage => _successFetchMessage;
  @computed
  int get messageIndex => _messageIndex;

  @computed
  List<MessageModel> get messagesWidgets => _messagesWidgets;

  // actions:-------------------------------------------------------------------
  @action
  Future setFetchMessage(bool val) async {
    _successFetchMessage = val;
    return _successFetchMessage;
  }

// actions:-------------------------------------------------------------------
  @action
  Future setMessageIndex(int val) async {
    _messageIndex = val;
    return _messageIndex;
  }

  // actions:-------------------------------------------------------------------
  @action
  Future insertMessage(val) async {
    this._messagesWidgets.insert(
          0,
          MessageModel.fromJson(map: val),
        );
    fetchListMessageFuture =
        ObservableFuture<List<MessageModel>>.value(_messagesWidgets)
            .catchError((error) {
      errorStore.isError = true;
      errorStore.errorTitle = "Error";
      errorStore.errorMessage = error.toString();
    });

    //that mean user send this question in this case will call bot api
    if (MessageModel.fromJson(map: val).senderId ==
        MessageModel.fromJson(map: val).userId) {
      print('=========== calling getMessage================');
    }

    return _messagesWidgets;
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    print('=========== calling dispose ================');
    resetListWidget("list");
  }
}
