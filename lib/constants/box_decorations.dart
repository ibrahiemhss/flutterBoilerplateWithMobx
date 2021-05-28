import 'package:flutter/material.dart';
import 'package:flutterBoilerplateWithMobx/constants/colors.dart';

class BoxDecorations {
  BoxDecorations._();

  static BoxDecoration screensBoxDecoration({required bool isDark}) =>
      BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [
          0.1,
          0.4,
          0.7,
          1.0,
          0.1,
          0.4,
          0.7,
          1.0,
        ],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          isDark ? AppColors.mainColor[600]! : Colors.white,
          isDark ? AppColors.mainColor[600]! : Colors.white,
          isDark ? AppColors.mainColor[600]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[700]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[700]! : Colors.white,
          isDark ? AppColors.mainColor[700]! : Colors.white,
          isDark ? AppColors.mainColor[800]! : Colors.white,
          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[50]!,
        ],
      ));

  static BoxDecoration roundCardBoxDecoration({required bool isDark}) =>
      BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [
            0.1,
            0.4,
            0.7,
            1.0,
            0.1,
            0.4,
            0.7,
            1.0,
          ],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            isDark ? AppColors.mainColor[600]! : AppColors.mainColor[50]!,
            isDark ? AppColors.mainColor[600]! : AppColors.mainColor[50]!,
            isDark ? AppColors.mainColor[600]! : AppColors.mainColor[50]!,
            isDark ? AppColors.mainColor[700]! : AppColors.mainColor[100]!,
            isDark ? AppColors.mainColor[700]! : AppColors.mainColor[100]!,
            isDark ? AppColors.mainColor[700]! : AppColors.mainColor[100]!,
            isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
            isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      );

  static BoxDecoration roundHeaderTextDecoration({required bool isDark}) =>
      BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [
            0.1,
            0.4,
            0.7,
            1.0,
            0.1,
            0.4,
            0.7,
            1.0,
          ],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
            isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
            isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
            isDark ? AppColors.mainColor[700]! : AppColors.mainColor[100]!,
            isDark ? AppColors.mainColor[700]! : AppColors.mainColor[100]!,
            isDark ? AppColors.mainColor[700]! : AppColors.mainColor[100]!,
            isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
            isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      );

  static BoxDecoration itemsBoxDecoration({required bool isDark}) =>
      BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.1, 0.4, 0.7, 1.0, 0.4, 0.7, 1.0, 0.4],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.

          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[700]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[700]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[700]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[50]!,
        ],
      ));

  static BoxDecoration appBarBoxDecoration({required bool isDark}) =>
      BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.1, 0.4, 0.7, 1.0, 0.1, 0.4, 0.7, 1.0],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          isDark ? AppColors.mainColor[900]! : AppColors.mainColor[200]!,
          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[100]!,
          isDark ? AppColors.mainColor[700]! : AppColors.mainColor[100]!,
          isDark ? AppColors.mainColor[700]! : AppColors.mainColor[300]!,
          isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
          isDark ? AppColors.mainColor[900]! : AppColors.mainColor[50]!,
          isDark ? AppColors.mainColor[900]! : AppColors.mainColor[50]!,
        ],
      ));

  static BoxDecoration neumorphicBoxDecoration({required bool isDark}) =>
      BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment(-1.0, -4.0),
            end: Alignment(1.0, 4.0),
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.4, 0.7, 1.0],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              isDark ? Colors.grey[700]! : AppColors.mainColor[100]!,
              isDark ? AppColors.mainColor[800]! : AppColors.mainColor[100]!,
              isDark ? AppColors.mainColor[800]! : AppColors.mainColor[200]!,
              isDark ? AppColors.mainColor[700]! : AppColors.mainColor[100]!,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(35)),
          boxShadow: [
            BoxShadow(
                color: isDark
                    ? AppColors.mainColor[800]!
                    : AppColors.mainColor[100]!,
                offset: Offset(5.0, 5.0),
                blurRadius: 15.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: isDark
                    ? AppColors.mainColor[600]!
                    : AppColors.mainColor[50]!,
                offset: Offset(-5.0, -5.0),
                blurRadius: 15.0,
                spreadRadius: 1.0),
          ]);

  static BoxDecoration buttonBoxDecoration({required bool isDark}) =>
      BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment(-1.0, -4.0),
            end: Alignment(1.0, 4.0),
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.4, 0.7, 1.0, 0.1, 0.4, 0.7, 1.0],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              isDark ? AppColors.mainColor[800]! : AppColors.mainColor[100]!,
              isDark ? AppColors.mainColor[900]! : AppColors.mainColor[200]!,
              isDark ? AppColors.mainColor[900]! : AppColors.mainColor[200]!,
              isDark ? AppColors.mainColor[900]! : AppColors.mainColor[200]!,
              isDark ? AppColors.mainColor[900]! : AppColors.mainColor[200]!,
              isDark ? AppColors.mainColor[900]! : AppColors.mainColor[200]!,
              isDark ? AppColors.mainColor[900]! : AppColors.mainColor[200]!,
              isDark ? AppColors.mainColor[800]! : AppColors.mainColor[100]!,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(35)),
          boxShadow: [
            BoxShadow(
                color: isDark
                    ? AppColors.mainColor[800]!
                    : AppColors.mainColor[100]!,
                offset: Offset(5.0, 5.0),
                blurRadius: 15.0,
                spreadRadius: 1.0),
            BoxShadow(
                color: isDark
                    ? AppColors.mainColor[600]!
                    : AppColors.mainColor[50]!,
                offset: Offset(-5.0, -5.0),
                blurRadius: 15.0,
                spreadRadius: 20.0),
          ]);
}
