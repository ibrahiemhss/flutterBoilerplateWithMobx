import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutterBoilerplateWithMobx/stores/user/user_store.dart';
import 'package:flutterBoilerplateWithMobx/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutterBoilerplateWithMobx/constants/box_decorations.dart';
import 'package:flutterBoilerplateWithMobx/constants/dimens.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/navigation/navigation_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/ui/home/home.dart';
import 'package:flutterBoilerplateWithMobx/utils/locale/app_localization.dart';
import 'package:flutterBoilerplateWithMobx/widgets/bas_app_bar.dart';

import 'drawer_items.dart';

class MainPageScreen extends StatefulWidget {
  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen>
    with SingleTickerProviderStateMixin {
  //stores:---------------------------------------------------------------------
  NavigationStore? _navigationStore;
  ThemeStore? _themeStore;
  LanguageStore? _languageStore;
  UserStore? _userDataStore;
  TabController? _tabController;

  @override
  void initState() {
    print("Here is main screen");
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _navigationStore!.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _navigationStore = Provider.of<NavigationStore>(context);
    _userDataStore = Provider.of<UserStore>(context);
    if (_navigationStore != null) {
      _navigationStore!.setPageAppBarTitle("home");
    }
  }

  GlobalKey<OverlayState> _overlayState = GlobalKey<OverlayState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: BasAppBar(
            title: AppLocalizations.of(context)
                .translate(_navigationStore!.pageAppBarTitle),
            appBar: AppBar(),
            overlayState: _overlayState,
            navigationStore: _navigationStore!,
            themeStore: _themeStore!,
            languageStore: _languageStore!,
            leading: Builder(
                builder: (context) => IconButton(
                    icon: new Icon(MaterialIcons.menu),
                    onPressed: () {
                      try {
                        if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                          _scaffoldKey.currentState!.openDrawer();
                        } else {
                          _scaffoldKey.currentState!.openEndDrawer();
                        }
                      } catch (e) {
                        print("catch e open darwer=${e.toString()}");
                      }
                    })),
          ),
          drawer: Container(
            decoration: BoxDecorations.screensBoxDecoration(
                isDark: _themeStore!.darkMode ? true : false),
            child: Container(
                margin: const EdgeInsets.only(top: Dimens.horizontal_padding),
                width: Dimens.screenWidth(context) * 0.7,
                child: Observer(builder: (context) {
                  return ListView(
                      children: DrawerItems(
                          userDataStore: _userDataStore,
                          overlayState: _overlayState,
                          context: context,
                          selectedIndex: _navigationStore!.drawerIndex,
                          onpress: (
                              {Widget? screen,
                              String? screenTitle,
                              int? index}) {
                            if (screen != null) {
                              try {
                                //if (_overlayState.currentContext != null) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.main,
                                    (Route<dynamic> route) => false);
                                // }
                              } catch (e) {}
                            }
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              _navigationStore!.setDrawerIndex(index!);
                              if (screen != null) {
                                _navigationStore!.setScreen(screen);
                              }
                              if (screenTitle != null) {
                                _navigationStore!
                                    .setPageAppBarTitle(screenTitle);
                              }
                            });
                          },
                          themeStore: _themeStore!,
                          languageStore: _languageStore!,
                          navigationStore: _navigationStore!));
                })),
          ),
          body: _navigationStore!.screen,
        );
      }),
    );
  }
}
