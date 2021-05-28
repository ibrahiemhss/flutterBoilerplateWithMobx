import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterBoilerplateWithMobx/constants/colors.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/utils/builder/dialog_utils.dart';
import 'package:flutterBoilerplateWithMobx/utils/locale/app_localization.dart';
import 'package:flutterBoilerplateWithMobx/utils/routes/routes.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:ndialog/ndialog.dart';

class LanguageDialogWidget {
  static LanguageDialogWidget _instance = new LanguageDialogWidget.internal();

  LanguageDialogWidget.internal();

  factory LanguageDialogWidget() => _instance;

  static Widget materialDialogWidget(
      {required BuildContext context,
      required ThemeStore themeStore,
      required LanguageStore languageStore,
      required GlobalKey<OverlayState> overlayState,
      required String title}) {
    return MaterialDialog(
      borderRadius: 5.0,
      enableFullWidth: true,
      title: Text(
        AppLocalizations.of(context).translate('chooseLanguage'),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      headerColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      closeButtonColor: Colors.white,
      enableCloseButton: true,
      enableBackButton: false,
      onCloseButtonClicked: () {
        Navigator.of(context).pop();
      },
      children: languageStore.supportedLanguages
          .map(
            (object) => ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0.0),
              title: Text(
                object.language!,
                style: TextStyle(
                  color: languageStore.locale == object.locale
                      ? Theme.of(context).primaryColor
                      : themeStore.darkMode
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                // change user language based on selected locale
                languageStore.changeLanguage(object.locale!);
              },
            ),
          )
          .toList(),
    );
    /* await Dialogs.materialDialog(
        //msg: 'Are you sure ? you can\'t undo this',
        title: title,
        color: Colors.white,
        context: context,
        actions: languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Center(
                  child: Text(
                    object.language,
                    style: TextStyle(
                      color: languageStore.locale == object.locale
                          ? AppColors.mainColor[500]!
                          : themeStore.darkMode
                              ? Colors.white
                              : Colors.grey[700]!,
                    ),
                  ),
                ),
                onTap: () {
                  // change user language based on selected locale
                  languageStore.changeLanguage(object.locale);

                  if (overlayState != null) {
                    Navigator.of(overlayState.currentContext!,
                            rootNavigator: true)
                        .pushReplacementNamed(Routes.main);
                  }
                },
              ),
            )
            .toList());*/
    /*MaterialDialog(
        key: overlayState,
        borderRadius: 5.0,
        title: Text(
          title,
          style: TextStyle(
              color: themeStore.darkMode
                  ? Colors.white
                  : AppColors.mainColor[500]!,
              fontSize: themeData.textTheme.subtitle2!.fontSize),
        ),
        headerColor: themeStore.darkMode
            ? AppColors.mainColor[500]!
            : AppColors.mainColor[50]!,
        backgroundColor: themeStore.darkMode ? Colors.grey[700]! : Colors.white,
        closeButtonColor: themeStore.darkMode
            ? themeDataDark.iconTheme.color
            : themeData.iconTheme.color,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(overlayState.currentContext!, rootNavigator: true).pop();
        },
        children: languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Center(
                  child: Text(
                    object.language,
                    style: TextStyle(
                      color: languageStore.locale == object.locale
                          ? AppColors.mainColor[500]!
                          : themeStore.darkMode
                              ? Colors.white
                              : Colors.grey[700]!,
                    ),
                  ),
                ),
                onTap: () {
                  // change user language based on selected locale
                  languageStore.changeLanguage(object.locale);

                  Navigator.of(overlayState.currentContext!,
                          rootNavigator: true)
                      .pop();
                },
              ),
            )
            .toList());*/
  }
}
