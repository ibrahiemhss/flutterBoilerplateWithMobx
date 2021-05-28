import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAnimation {
  static Widget stillLoading({double? size, Color? color}) {
    return SpinKitThreeBounce(
      color: color ?? Colors.black12,
      size: size ?? 50.0,
    );
  }
}
