import 'dart:async';

import 'package:flutterBoilerplateWithMobx/constants/strings.dart';
import 'package:flutterBoilerplateWithMobx/data/local/datasources/post/post_datasource.dart';
import 'package:flutterBoilerplateWithMobx/data/sharedpref/shared_preference_helper.dart';
import 'package:flutterBoilerplateWithMobx/models/notifications/fcm_notification_model.dart';
import 'package:flutterBoilerplateWithMobx/models/notifications/received_notification.dart';
import 'package:flutterBoilerplateWithMobx/models/post/post.dart';
import 'package:flutterBoilerplateWithMobx/models/post/post_list.dart';
import 'package:flutterBoilerplateWithMobx/models/user/user_model.dart';
import 'package:sembast/sembast.dart';

import 'firebase/firebase_messaging.dart';
import 'local/constants/db_constants.dart';
import 'network/apis/posts/post_api.dart';
import 'network/apis/sendMessage/send_message.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;
  final SendMessageApi _sendMessageApi;
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final FirebaseMessagingHelper _firebaseMessagingHelper;

  // constructor
  Repository(this._postApi, this._sendMessageApi, this._sharedPrefsHelper,
      this._firebaseMessagingHelper, this._postDataSource);

  // Post: ---------------------------------------------------------------------
  Future<PostList> getPosts() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postApi.getPosts().then((postsList) {
      postsList.posts?.forEach((post) {
        _postDataSource.insert(post);
      });

      return postsList;
    }).catchError((error) => throw error);
  }

  Future<List<Post>> findPostById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(Post post) => _postDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    return await Future.delayed(Duration(seconds: 2), () => true);
  }

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;

  // user data info: -----------------------------------------------------------------
  void saveUserData(Map<dynamic, dynamic> value) {
    _sharedPrefsHelper.saveUserData(value);
  }

  UserModel getUserData() {
    //print("test values from usermodel =${_sharedPreference.getString(Preferences.userData)}");
    return _sharedPrefsHelper.getUserData();
  }

  void changeIsFirstEntry(bool value) {
    _sharedPrefsHelper.changeIsFirstEntry(value);
  }

  @override
  bool get isFirstEntry {
    return _sharedPrefsHelper.isFirstEntry;
  }

  // UserType: -----------------------------------------------------------------
  void setUserType(int value) {
    print("=====user type is ===$value========");
    _sharedPrefsHelper.setUserType(value);
  }

  @override
  int get userType {
    return _sharedPrefsHelper.userType;
  }

  // Fcm Notifications: -----------------------------------------------------------------
  Future<String> sendNotification(FcmMessage fcmMessage) async {
    return await _sendMessageApi
        .sendAndRetrieveFcmMessage(fcmMessage)
        .catchError((error) => throw error);
  }

  ReceivedNotification? initializationSettingsIOS() {
    return _firebaseMessagingHelper.initializationSettingsIOS();
  }

  void initializationFlutterLocalNotificationsPlugin() {
    _firebaseMessagingHelper.initializationFlutterLocalNotificationsPlugin();
  }

  String initializationNotificationSettings() {
    return _firebaseMessagingHelper.initializationNotificationSettings()!;
  }
}
