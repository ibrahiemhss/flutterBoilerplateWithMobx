import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutterBoilerplateWithMobx/constants/app_theme.dart';
import 'package:flutterBoilerplateWithMobx/constants/assets.dart';
import 'package:flutterBoilerplateWithMobx/constants/colors.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/navigation/navigation_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/user/user_store.dart';
import 'package:flutterBoilerplateWithMobx/ui/home/home.dart';
import 'package:flutterBoilerplateWithMobx/ui/profile/profile_screen.dart';
import 'package:flutterBoilerplateWithMobx/utils/builder/dialog_utils.dart';
import 'package:flutterBoilerplateWithMobx/utils/locale/app_localization.dart';
import 'package:flutterBoilerplateWithMobx/utils/routes/routes.dart';
import 'package:flutterBoilerplateWithMobx/widgets/app_icon_widget.dart';
import 'package:flutterBoilerplateWithMobx/widgets/language_dialog_widget.dart';

Color? backgroundColor(ThemeStore theme, int index, int selectedIndex) {
  if (index == selectedIndex) {
    return theme.darkMode
        ? AppColors.mainColor[400]!
        : AppColors.mainColor[50]!;
  } else {
    return theme.darkMode ? themeDataDark.backgroundColor : Colors.white;
  }
}

List<Widget> DrawerItems(
    {required BuildContext? context,
    required ThemeStore? themeStore,
    required UserStore? userDataStore,
    required LanguageStore? languageStore,
    required NavigationStore navigationStore,
    required int? selectedIndex,
    required Function({Widget screen, String screenTitle, int index}) onpress,
    required GlobalKey<OverlayState>? overlayState}) {
  return [
    Center(child: AppIconWidget(image: Assets.appLogo)),
    //--------------------------------------------------------------------------
    Divider(),
    Container(
      color: backgroundColor(themeStore!, 0, navigationStore.drawerIndex),
      child: ListTile(
          title: Text(AppLocalizations.of(context!).translate('home'),
              style: Theme.of(context).textTheme.subtitle1),
          trailing: Icon(MaterialIcons.home),
          onTap: () {
            onpress(screen: HomeScreen(), screenTitle: "home", index: 0);
            print("selectedIndex darwer item =${navigationStore.drawerIndex}");
          }),
    ),
    //--------------------------------------------------------------------------
    //--------------------------------------------------------------------------
/*
    Divider(),
    ListTile(
        title: Text(AppLocalizations.of(context)!.translate('chatBot') ?? "",
            style: Theme.of(context).textTheme.subtitle1),
        trailing: Icon(MaterialCommunityIcons.robot),
        onTap: () {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            navigationStore.setPageAppBarTitle("chatBot");
            navigationStore.setScreen(ChatScreen());
          });

          // Navigator.of(context).pop();
        }),

    ///--------------------------------------------------------------------------
*/

    Divider(),
    Container(
      color: backgroundColor(themeStore, 1, navigationStore.drawerIndex),
      child: ListTile(
          title: Text(AppLocalizations.of(context).translate('myAccount'),
              style: Theme.of(context).textTheme.subtitle1),
          trailing: Icon(MaterialCommunityIcons.account_details),
          onTap: () {
            onpress(
                screen: ProfileScreen(), screenTitle: "myAccount", index: 1);

            print("selectedIndex darwer item =${navigationStore.drawerIndex}");

            //Navigator.of(context).pop();
          }),
    ),

    ///--------------------------------------------------------------------------
    Divider(),
    Container(
      color: backgroundColor(themeStore, 2, navigationStore.drawerIndex),
      child: ListTile(
          title: Text(AppLocalizations.of(context).translate('language'),
              style: Theme.of(context).textTheme.subtitle1),
          trailing: Icon(MaterialIcons.language),
          onTap: () async {
            onpress(index: 2);

            DialogUtils.showCustomDialog(context,
                widget: LanguageDialogWidget.materialDialogWidget(
                    themeStore: themeStore,
                    languageStore: languageStore!,
                    overlayState: overlayState!,
                    title:
                        "${AppLocalizations.of(context).translate('chooseLanguage')}",
                    context: context)
                /*await LanguageDialogWidget.materialDialogWidget(
                    themeStore: themeStore!,
                    languageStore: languageStore!,
                    overlayState: overlayState!,
                    title:
                        "${AppLocalizations.of(context).translate('chooseLanguage')}",
                    context: context)*/
                );
            print("selectedIndex darwer item =${navigationStore.drawerIndex}");
          }),
    ),
    //--------------------------------------------------------------------------
    Divider(),
    Container(
      color: backgroundColor(themeStore, 3, navigationStore.drawerIndex),
      child: ListTile(
          title: Text(AppLocalizations.of(context).translate('logOut'),
              style: Theme.of(context).textTheme.subtitle1),
          trailing: Icon(MaterialIcons.logout),
          onTap: () {
            onpress(index: 3);
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              userDataStore!.logout();
              Navigator.of(context).pushReplacementNamed(Routes.login);
            });
            print("selectedIndex darwer item =${navigationStore.drawerIndex}");
          }),
    ),

    //--------------------------------------------------------------------------
    Divider(),
    Container(
      color: backgroundColor(themeStore, 4, navigationStore.drawerIndex),
      child: ListTile(
          title: Text(
              "${AppLocalizations.of(context).translate('theme')} : "
              "${themeStore.darkMode ? AppLocalizations.of(context).translate('dark') : AppLocalizations.of(context).translate('light')}",
              style: Theme.of(context).textTheme.subtitle1),
          trailing: Icon(
              themeStore.darkMode ? Ionicons.ios_sunny : Ionicons.ios_moon),
          onTap: () {
            onpress(index: 4);
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              themeStore.changeBrightnessToDark(!themeStore.darkMode);
            });
            print("selectedIndex darwer item =${navigationStore.drawerIndex}");
          }),
    ),

    //--------------------------------------------------------------------------
    Divider(),
    Container(
      color: backgroundColor(themeStore, 5, navigationStore.drawerIndex),
      child: ListTile(
          title: Text(
              "${AppLocalizations.of(context).translate('version')} : 1",
              style: Theme.of(context).textTheme.subtitle1),
          trailing: Icon(Octicons.versions),
          onTap: () {
            onpress(index: 5);
            print("selectedIndex darwer item =${navigationStore.drawerIndex}");
            //onpress(screen: HomeScreen(), title: "home");
          }),
    ),
    Divider(),
  ];
}
