import 'package:flutterBoilerplateWithMobx/constants/general_constants.dart';
import 'package:flutterBoilerplateWithMobx/models/notifications/fcm_notification_model.dart';
import 'package:flutterBoilerplateWithMobx/models/user/user_model.dart';
import 'package:flutterBoilerplateWithMobx/stores/error/error_store.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository.dart';
import '../form/form_store.dart';

part 'user_store.g.dart';

@Injectable()
class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  UserModel mUserModel = new UserModel(
      id: 1,
      name: "name",
      email: "www@www.com",
      address: "address",
      birthday: "birthday",
      userTypeId: "type",
      registrationTime: "11-11-2021",
      displayName: "displayName",
      password: "11111",
      phone: "111111");

  // repository instance
  final Repository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : this._repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.isLoggedIn.then((value) {
      this.isLoggedIn = value;
    });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => _successLogIn, resetSuccessLogIn, delay: 200),
      reaction((_) => _successRegistration, resetSuccessRegistration,
          delay: 200),
      reaction((_) => _successLogout, resetSuccessLogout, delay: 200),
    ];
  }

  @action
  void resetSuccessLogIn(bool value) {
    print('calling reset LogIn');
    this._successLogIn = false;
  }

  @action
  void resetSuccessRegistration(bool value) {
    print('calling reset Registration');
    this._successRegistration = false;
  }

  @action
  void resetSuccessLogout(bool value) {
    print('calling reset Logout');
    this._successLogout = false;
  }

  // general:-------------------------------------------------------------------
  void init() {
    _userType = _repository.userType;
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<bool> emptyLoginResponse =
      ObservableFuture.value(false);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<bool> loginFuture = emptyLoginResponse;
  @observable
  UserModel? _userModel;
  @observable
  int? _userType;
  @observable
  FcmMessage? _fcmMessage;
  @observable
  bool _successLogIn = false;
  @observable
  bool _successLogout = false;
  @observable
  bool _successRegistration = false;
  @observable
  bool _loadingData = false;

  @observable
  String _fcmToken = "";

  @computed
  String get fcmToken => _fcmToken;

  @computed
  bool get loadingData => _loadingData;

  @computed
  UserModel get userModel => _userModel!;

  @computed
  int get userType => _userType!;

  @computed
  @computed
  bool get successLogIn => _successLogIn;

  @computed
  bool get successLogout => _successLogout;

  @computed
  bool get successRegistration => _successRegistration;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String email, String password) async {
    final future = _repository.login(email, password);
    this._loadingData = true;
    loginFuture = ObservableFuture(future);
    Future.delayed(Duration(milliseconds: 2000)).then((future) {
      this._loadingData = false;
      this.isLoggedIn = true;
      this._successLogIn = true;
      success = true;
      _repository.saveIsLoggedIn(true);
    }).catchError((e) {
      this.isLoggedIn = false;
      success = false;
      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
    await future.then((value) async {
      if (value) {
        _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        this.success = true;
        _loadingData = false;
      } else {
        print('failed to login');
      }
    }).catchError((e) {
      print(e);
      _loadingData = false;
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  logout() {
    this.isLoggedIn = false;
    _repository.saveIsLoggedIn(false);
  }

  @action
  Future saveUser(UserModel userModel) async {
    this.isLoggedIn = true;
    _repository.saveIsLoggedIn(true);
    _repository.saveUserData(mUserModel.toMap());
  }

  @action
  Future<void> checkUserFound(UserModel userModel) async {
    this.isLoggedIn = true;
    _repository.saveIsLoggedIn(true);
    _repository.saveUserData(mUserModel.toMap());
    login(mUserModel.name, mUserModel.email);
  }

  @action
  Future getUserData() async {
    _userModel = _repository.getUserData();
    init();
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
