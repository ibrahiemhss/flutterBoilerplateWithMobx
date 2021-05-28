import 'package:flutter/material.dart';
import 'package:flutterBoilerplateWithMobx/constants/box_decorations.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final ThemeStore themeStore;
  final double? width;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.themeStore,
    required this.textColor,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorations.neumorphicBoxDecoration(
          isDark: themeStore.darkMode ? true : false),
      width: width ?? double.infinity,
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 8),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
