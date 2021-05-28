import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutterBoilerplateWithMobx/constants/box_decorations.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/navigation/navigation_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/utils/builder/dialog_utils.dart';
import 'package:flutterBoilerplateWithMobx/utils/locale/app_localization.dart';

import 'language_dialog_widget.dart';

class BasAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<OverlayState>? overlayState;
  final NavigationStore? navigationStore;
  final ThemeStore? themeStore;
  final LanguageStore? languageStore;
  final String? title;
  final AppBar? appBar;
  final Function? onPress;
  final Widget? leading;

  const BasAppBar(
      {Key? key,
      this.overlayState,
      this.navigationStore,
      this.themeStore,
      this.languageStore,
      this.appBar,
      this.onPress,
      this.leading,
      this.title})
      : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(appBar!.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /* shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),*/
      flexibleSpace: Container(
        decoration: BoxDecorations.appBarBoxDecoration(
            isDark: themeStore!.darkMode ? true : false),
      ),
      leading: leading == null
          ? null
          : Builder(
              builder: (context) => IconButton(
                  icon: leading!,
                  onPressed: () {
                    onPress!();
                  })),
      title: Text(title ?? ""),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      // _buildLanguageButton(context),
      //_buildThemeButton(),
      // _buildLogoutButton(),
    ];
  }

  Widget _buildLanguageButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        DialogUtils.showCustomDialog(context,
            widget: await LanguageDialogWidget.materialDialogWidget(
                themeStore: themeStore!,
                languageStore: languageStore!,
                overlayState: overlayState!,
                title:
                    "${AppLocalizations.of(context).translate('chooseLanguage')}",
                context: context));
      },
      icon: Icon(
        MaterialIcons.language,
      ),
    );
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            themeStore!.changeBrightnessToDark(!themeStore!.darkMode);
          },
          icon: Icon(
            themeStore!.darkMode ? Ionicons.ios_sunny : Ionicons.ios_moon,
          ),
        );
      },
    );
  }
}
