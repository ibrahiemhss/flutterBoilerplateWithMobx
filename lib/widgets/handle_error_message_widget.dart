import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';

class HandleWarnMessage {
  static HandleWarnMessage _instance = new HandleWarnMessage.internal();

  HandleWarnMessage.internal();

  factory HandleWarnMessage() => _instance;

  Widget HandleErrorMessage(
      {required BuildContext context,
      required String errorMessage,
      required ThemeStore themeStore,
      required String title,
      required bool isError}) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (errorMessage != null && errorMessage.isNotEmpty) {
        Flushbar(
          titleColor:
              getTextColor(isError == null ? true : isError, themeStore),
          messageColor: getTextColor(isError, themeStore),
          title: title == null ? "" : title,
          message: errorMessage == null ? "" : errorMessage,
          backgroundColor:
              themeStore.darkMode ? Colors.red[900]! : Colors.red[200]!,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  Color? getTextColor(bool isError, ThemeStore themeStore) {
    if (!isError) {
      print(
          "============HandleErrorMessage TextColor isError 1 ======= ${isError.toString()} ");

      return themeStore.darkMode ? Colors.green[50] : Colors.green[900];
    } else {
      print(
          "============HandleErrorMessage TextColor isError 12 ======= ${isError.toString()} ");

      return themeStore.darkMode ? Colors.red[50] : Colors.red[900];
    }
  }

  Color? getBackgroundColor(bool isError, ThemeStore themeStore) {
    if (!isError) {
      print(
          "============HandleErrorMessage BackgroundColor isError 1 ======= ${isError.toString()} ");

      return themeStore.darkMode ? Colors.green[900]! : Colors.green[200];
    } else {
      print(
          "============HandleErrorMessage BackgroundColor isError 2 ======= ${isError.toString()} ");

      return themeStore.darkMode ? Colors.red[900]! : Colors.red[200];
    }
  }
}
