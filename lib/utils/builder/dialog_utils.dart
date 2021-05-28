import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context, {required Widget widget}) {
    showDialog(
        context: context,
        builder: (_) {
          return widget;
        });
  }
}
