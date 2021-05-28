import 'dart:async';
import 'dart:convert';

import 'package:flutterBoilerplateWithMobx/models/user/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

@Singleton()
class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.authToken);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.authToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.authToken);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.isLoggedIn) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.isLoggedIn, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.isDarkMode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.isDarkMode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.currentLanguage);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.currentLanguage, language);
  }

  // user data info: -----------------------------------------------------------------
  void saveUserData(Map<dynamic, dynamic> value) {
    _sharedPreference.setString(Preferences.userData, json.encode(value));
  }

  UserModel getUserData() {
    //print("test values from usermodel =${_sharedPreference.getString(Preferences.userData)}");

    if (_sharedPreference.getString(Preferences.userData) != null) {
      return UserModel.fromMap(json.decode(
              _sharedPreference.getString(Preferences.userData) ?? "") ??
          "");
    } else {
      return UserModel();
    }
  }

  void changeIsFirstEntry(bool value) {
    _sharedPreference.setBool(Preferences.isFirstEntry, value);
  }

  @override
  bool get isFirstEntry {
    return _sharedPreference.getBool(Preferences.isFirstEntry) ?? true;
  }

  // UserType: -----------------------------------------------------------------
  void setUserType(int value) {
    print("=====user type is ===$value========");
    _sharedPreference.setInt(Preferences.userType, value);
  }

  int get userType {
    return _sharedPreference.getInt(Preferences.userType) ?? 0;
  }

  void saveFcmToken(String authToken) {
    _sharedPreference.setString(Preferences.fcmToken, authToken);
  }

  // Save Firebase messaging token: -----------------------------------------------------------------

  void removeFcmToken() {
    _sharedPreference.remove(Preferences.fcmToken);
  }
}
