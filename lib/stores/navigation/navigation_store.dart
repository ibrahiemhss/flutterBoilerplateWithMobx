import 'package:flutter/cupertino.dart';
import 'package:flutterBoilerplateWithMobx/data/repository.dart';
import 'package:flutterBoilerplateWithMobx/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';
import 'package:flutterBoilerplateWithMobx/ui/home/home.dart';

part 'navigation_store.g.dart';

class NavigationStore = navigationStore with _$NavigationStore;

abstract class navigationStore with Store {
  final Repository? _repository;
// constructor:---------------------------------------------------------------
  navigationStore(Repository? repository) : this._repository = repository {
    _initSlider();
    _setupNavigationIndex();
  }
  // store variables:-----------------------------------------------------------
  @observable
  int _pageIndex = 0;
  @observable
  int _drawerIndex = 0;
  @observable
  String _pageAppBarTitle = 'home';
  @observable
  String _route = Routes.login; // HomePageScreen();
  @observable
  Widget _screen = HomeScreen(); // HomePageScreen();
  @observable
  int _slideIndex = 0;
  @observable
  bool _isFirstEntry = false;
  @observable
  int _userType = 0;
  @observable
  bool loading = false;

// getters:-------------------------------------------------------------------
  @computed
  int get pageIndex => _pageIndex;

  @computed
  int get drawerIndex => _drawerIndex;

  @computed
  String get route => _route;

  @computed
  String get pageAppBarTitle => _pageAppBarTitle;

  @computed
  Widget get screen => _screen;
  @computed
  int get getSlideIndex => _slideIndex;

  @computed
  bool get isFirstEntry => _isFirstEntry;

  @computed
  int get getUserType => _userType;

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer>? _disposers;

  void _setupNavigationIndex() {
    _disposers = [
      reaction((_) => _pageIndex, indexIfNull),
    ];
  }

  @action
  void indexIfNull(int value) {}

  // actions:-------------------------------------------------------------------
  @action
  void setPageIndex(int value) {
    _pageIndex = value;
  }

  @action
  void setDrawerIndex(int value) {
    _drawerIndex = value;
  }

  @action
  void setPageAppBarTitle(String value) {
    _pageAppBarTitle = value;
  }

  @action
  void setRoute(String value) {
    _route = value;
  }

  @action
  void setScreen(Widget value) {
    _screen = value;
  }

  @action
  void setSlideIndex(int value) {
    _slideIndex = value;
  }

  @action
  void changeFirstEntry(bool value) {
    _isFirstEntry = value;
    _repository?.changeIsFirstEntry(value);
  }

  // actions:-------------------------------------------------------------------
  @action
  void changeUserType(int value) {
    _userType = value;
    _repository?.setUserType(value);
  }

  // general methods:-----------------------------------------------------------

  void _initSlider() async {
    // getting current language from shared preference
    _isFirstEntry = _repository!.isFirstEntry;
    _userType = _repository!.userType;
  }

  void dispose() {
    _screen = HomeScreen();
    for (final d in _disposers!) {
      d();
    }
  }
}
