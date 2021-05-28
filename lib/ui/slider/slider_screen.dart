import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterBoilerplateWithMobx/constants/general_constants.dart';
import 'package:flutterBoilerplateWithMobx/stores/navigation/navigation_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/user/user_store.dart';
import 'package:flutterBoilerplateWithMobx/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutterBoilerplateWithMobx/constants/assets.dart';
import 'package:flutterBoilerplateWithMobx/constants/box_decorations.dart';
import 'package:flutterBoilerplateWithMobx/constants/colors.dart';
import 'package:flutterBoilerplateWithMobx/data/sharedpref/constants/preferences.dart';
import 'package:flutterBoilerplateWithMobx/models/slider/slider_model.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/utils/locale/app_localization.dart';
import 'package:flutterBoilerplateWithMobx/widgets/progress_indicator_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  List<SliderModel> _mySLides = [];
  PageController? _controller;
  ThemeStore? _themeStore;
  NavigationStore? _navigationStore;
  UserStore? _userStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _navigationStore = Provider.of<NavigationStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _userStore = Provider.of<UserStore>(context);
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: 10.0,
      width: isCurrentPage ? 13.0 : 20.0,
      decoration: BoxDecoration(
        color: isCurrentPage
            ? AppColors.mainColor[900]!
            : AppColors.mainColor[400]!,
        borderRadius: BorderRadius.all(
            Radius.circular(30.0) //                 <--- border radius here
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _mySLides = getSlides();
    _controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMainContent(context),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Observer(
      builder: (context) {
        return _navigationStore! == null
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildView(context));
      },
    );
  }

  Widget _buildView(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecorations.screensBoxDecoration(
            isDark: _themeStore!.darkMode ? true : false),
        child: Scaffold(
          body: PageView(
            controller: _controller,
            onPageChanged: (index) {
              _navigationStore!.setSlideIndex(index);
            },
            children: <Widget>[
              SlideTile(
                imagePath: _mySLides[0].getImageAssetPath(),
                title: _mySLides[0].getTitle(),
                desc: _mySLides[0].getDesc(),
              ),
              SlideTile(
                imagePath: _mySLides[1].getImageAssetPath(),
                title: _mySLides[1].getTitle(),
                desc: _mySLides[1].getDesc(),
              ),
              SlideTile(
                imagePath: _mySLides[2].getImageAssetPath(),
                title: _mySLides[2].getTitle(),
                desc: _mySLides[2].getDesc(),
              )
            ],
          ),
          bottomSheet: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 3; i++)
                        i == _navigationStore!.getSlideIndex
                            ? _buildPageIndicator(false)
                            : _buildPageIndicator(true),
                    ],
                  ),
                ),
                _navigationStore!.getSlideIndex != 2
                    ? Container(
                        color: Colors.transparent,
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.all(15),
                                onPressed: () {
                                  _controller!.animateToPage(
                                      _navigationStore!.getSlideIndex + 1,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.linear);
                                },
                                color: AppColors.mainColor[600]!,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                splashColor: Colors.tealAccent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: SizedBox()),
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('next'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.tealAccent,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Icon(
                                      Icons.chevron_right_sharp,
                                      color: Colors.tealAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            OutlineButton(
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                _controller!.animateToPage(2,
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.linear);
                              },
                              splashColor: Colors.cyanAccent,
                              child: Text(
                                AppLocalizations.of(context).translate('skip'),
                                //////
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        color: Colors.transparent,
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: FlatButton(
                          padding: EdgeInsets.all(15),
                          onPressed: () async {
                            await gooScreen(context);
                          },
                          color: AppColors.mainColor[600]!,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          splashColor: Colors.blue[50]!,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: SizedBox()),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('finish'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gooScreen(BuildContext context) async {
    _navigationStore!.changeFirstEntry(false);
    if (_userStore!.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed(Routes.main);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}

class SlideTile extends StatelessWidget {
  final String? imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Assets.appLogo,
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Center(
            child: Text(
              title!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(
            imagePath!,
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 10,
          ),
          Text(desc!,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18))
        ],
      ),
    );
  }
}
