//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutterBoilerplateWithMobx/stores/user/user_store.dart';
import 'package:provider/provider.dart';
import 'package:flutterBoilerplateWithMobx/constants/assets.dart';
import 'package:flutterBoilerplateWithMobx/constants/box_decorations.dart';
import 'package:flutterBoilerplateWithMobx/constants/colors.dart';
import 'package:flutterBoilerplateWithMobx/constants/dimens.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/navigation/navigation_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/widgets/progress_indicator_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //stores:---------------------------------------------------------------------
  ThemeStore? _themeStore;
  UserStore? _userDataStore;
  NavigationStore? _navigationStore;
  LanguageStore? _languageStore;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _userDataStore = Provider.of<UserStore>(context);
    _navigationStore = Provider.of<NavigationStore>(context);
    _languageStore = Provider.of<LanguageStore>(context);
    if (_navigationStore! != null) {
      _navigationStore!.setPageAppBarTitle("accountInformation");
    }
    if (_userDataStore! != null) {
      _userDataStore!.getUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //appBar: BasAppBar(appBar: AppBar(),scaffoldKey: _scaffoldKey,navigationStore: navigationStore!,themeStore: themeStore!,languageStore: languageStore!, leading: null),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Observer(
      builder: (context) {
        return _userDataStore!.loadingData
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildView(context));
      },
    );
  }

  _buildView(BuildContext context) {
    return Scaffold(
      // key: _overlayState,
      /*appBar: BasAppBar(
        title: navigationStore!.pageAppBarTitle,
        appBar: AppBar(),
        navigationStore: navigationStore!,
        themeStore: themeStore!,
        languageStore: languageStore!,
        onPress: () {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(Routes.main);
          });
        },
        leading: Icon(Icons.arrow_back_ios),
      ),*/
      /*  floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          width: 60,
          height: 60,
          child: Icon(Icons.edit),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.mainColor[500]!, AppColors.mainColor[300]!],
              )),
        ),
      ),*/
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.mainColor[300]!,
                        AppColors.mainColor[100]!
                      ],
                    ),
                  ),
                  child: Column(children: [
                    SizedBox(height: Dimens.screenHeight(context) / 20.0),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundImage: AssetImage(Assets.appLogo),
                      backgroundColor: AppColors.mainColor[50]!,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(_userDataStore!.userModel.displayName ?? "",
                        style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      _userDataStore!.userModel.email ?? "",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ]),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecorations.screensBoxDecoration(
                      isDark: _themeStore!.darkMode ? true : false),
                  child: Center(
                      child: Card(
                          margin: EdgeInsets.fromLTRB(0.0,
                              Dimens.screenHeight(context) / 9.0, 0.0, 0.0),
                          child: Container(
                              width: 310.0,
                              height: 290.0,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Information",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Divider(
                                      color: Colors.grey[300]!,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: AppColors.mainColor[900],
                                          size: 35,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Phone",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            Text(
                                              _userDataStore!.userModel.phone ==
                                                      ""
                                                  ? "Not added yet"
                                                  : _userDataStore!
                                                      .userModel.phone,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          MaterialCommunityIcons.account,
                                          color: AppColors.mainColor[900],
                                          size: 35,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Job",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            Text(
                                              _userDataStore!.userModel.job ==
                                                      ""
                                                  ? "Not added yet"
                                                  : _userDataStore!
                                                      .userModel.job,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Entypo.address,
                                          color: AppColors.mainColor[900],
                                          size: 35,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Address",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              _userDataStore!
                                                          .userModel.address ==
                                                      ""
                                                  ? "Not added yet"
                                                  : _userDataStore!
                                                      .userModel.address,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )))),
                ),
              ),
            ],
          ),
          Positioned(
              top: Dimens.screenHeight(context) * 0.35,
              left: 16.0,
              right: 16.0,
              child: Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Nominations\nCount',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          _userDataStore!.userModel.nominationsCount == ""
                              ? "0"
                              : _userDataStore!.userModel.nominationsCount,
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    )),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Acceptable\nNominations',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _userDataStore!.userModel.acceptableNominations ==
                                      ""
                                  ? "0"
                                  : _userDataStore!
                                      .userModel.acceptableNominations,
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ]),
                    ),
                  ],
                ),
              )))
        ],
      ),
    );
  }
}
