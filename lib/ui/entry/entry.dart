import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutterBoilerplateWithMobx/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutterBoilerplateWithMobx/constants/assets.dart';
import 'package:flutterBoilerplateWithMobx/constants/box_decorations.dart';
import 'package:flutterBoilerplateWithMobx/constants/dimens.dart';
import 'package:flutterBoilerplateWithMobx/constants/general_constants.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/navigation/navigation_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/widgets/app_icon_widget.dart';

class EntryScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<EntryScreen> {
  ///stores:--------------------------------------------------------------------
  ThemeStore? _themeStore;
  LanguageStore? _languageStore;
  NavigationStore? _navigationStore;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _navigationStore = Provider.of<NavigationStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  /// app bar methods:---------------------------------------------------------

  bool getUserType(int value) {
    if (value == GeneralConstants.user) {
      return true;
    } else {
      return false;
    }
  }

  /// body methods:-------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Column(
        children: <Widget>[
          Observer(
            builder: (context) {
              return Material(
                  child: Container(
                decoration: BoxDecorations.screensBoxDecoration(
                    isDark: _themeStore!.darkMode ? true : false),
                height: Dimens.screenHeight(context),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 64.0),
                        child: AppIconWidget(image: Assets.appLogo),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _navigationStore!
                                  .changeUserType(GeneralConstants.user);
                              _navigationStore!.changeFirstEntry(false);
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.login);
                            },
                            child: Container(
                              decoration:
                                  BoxDecorations.neumorphicBoxDecoration(
                                      isDark:
                                          _themeStore!.darkMode ? true : false),
                              width: Dimens.screenWidth(context) / 2.1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16, top: 8, bottom: 8),
                                child: Row(
                                  // Replace with a Row for horizontal icon + text
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Icon(
                                      MaterialIcons.chevron_left,
                                      size: 48,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    Text("Seeker",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _navigationStore!
                                  .changeUserType(GeneralConstants.company);
                              _navigationStore!.changeFirstEntry(false);
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.login);
                            },
                            child: Container(
                              decoration:
                                  BoxDecorations.neumorphicBoxDecoration(
                                      isDark:
                                          _themeStore!.darkMode ? true : false),
                              width: Dimens.screenWidth(context) / 2.1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12, top: 6, bottom: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("COMPANY",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    Icon(MaterialIcons.chevron_right,
                                        size: 48,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}
