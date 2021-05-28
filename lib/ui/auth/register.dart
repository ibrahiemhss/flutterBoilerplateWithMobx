import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterBoilerplateWithMobx/stores/user/user_store.dart';
import 'package:flutterBoilerplateWithMobx/utils/routes/routes.dart';
import 'package:flutterBoilerplateWithMobx/widgets/app_icon_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutterBoilerplateWithMobx/constants/assets.dart';
import 'package:flutterBoilerplateWithMobx/constants/box_decorations.dart';
import 'package:flutterBoilerplateWithMobx/constants/colors.dart';
import 'package:flutterBoilerplateWithMobx/constants/dimens.dart';
import 'package:flutterBoilerplateWithMobx/models/user/user_model.dart';
import 'package:flutterBoilerplateWithMobx/stores/form/form_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/utils/locale/app_localization.dart';
import 'package:flutterBoilerplateWithMobx/widgets/empty_app_bar_widget.dart';
import 'package:flutterBoilerplateWithMobx/widgets/handle_error_message_widget.dart';
import 'package:flutterBoilerplateWithMobx/widgets/progress_indicator_widget.dart';
import 'package:flutterBoilerplateWithMobx/widgets/rounded_button_widget.dart';
import 'package:flutterBoilerplateWithMobx/widgets/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore? _themeStore;
  UserStore? _userDataStore;
  LanguageStore? _languageStore;
  FormStore _formStore = FormStore();

  //focus node:-----------------------------------------------------------------
  FocusNode? _passwordFocusNode;
  FocusNode? _confirmPasswordFocusNode;

  //stores:---------------------------------------------------------------------
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _formStore = FormStore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _userDataStore = Provider.of<UserStore>(context);
    _languageStore = Provider.of<LanguageStore>(context);

    if (_userDataStore != null) {
      _userDataStore!.init();
    }
    if (_formStore != null) {
      _formStore.setupValidations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      //key: _scaffoldKey,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

// body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Observer(builder: (context) {
      print(
          "error message ========= =${_userDataStore!.errorStore.errorMessage}");

      return Stack(
        children: <Widget>[
          HandleWarnMessage.internal().HandleErrorMessage(
            context: context,
            themeStore: _themeStore!,
            title: _userDataStore!.errorStore.errorTitle,
            errorMessage: _userDataStore!.errorStore.errorMessage,
            isError: _userDataStore!.errorStore.isError,
          ),
          _buildMainContent(),
        ],
      );
    });
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        print(
            "loading status ============= ${_userDataStore!.loadingData.toString()} ===========");
        return _userDataStore!.loadingData
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildView());
      },
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildView() {
    return Container(
      decoration: BoxDecorations.screensBoxDecoration(
          isDark: _themeStore!.darkMode ? true : false),
      child: Stack(
        children: <Widget>[
          MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildLeftSide(),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildRightSide(),
                    ),
                  ],
                )
              : Center(child: _buildRightSide()),
          Observer(
            builder: (context) {
              return _userDataStore!.successRegistration
                  ? navigate(context)
                  : HandleWarnMessage.internal().HandleErrorMessage(
                      context: context,
                      title: _formStore.errorStore.errorTitle,
                      errorMessage: _formStore.errorStore.errorMessage,
                      isError: _formStore.errorStore.isError,
                      themeStore: _themeStore!);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _formStore.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        Assets.carBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppIconWidget(image: Assets.appLogo),
            //  AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            SizedBox(height: 24.0),
            _buildUserIdField(),
            _buildPasswordField(),
            _buildConfirmPasswordField(),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('enterUserEmail'),
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('enterPassword'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          inputAction: TextInputAction.next,
          errorText: _formStore.formErrorStore.password,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
          },
          onChanged: (value) {
            _formStore.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('reEnterPassword'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore!.darkMode ? Colors.white70 : Colors.black54,
          textController: _confirmPasswordController,
          focusNode: _confirmPasswordFocusNode,
          errorText: _formStore.formErrorStore.confirmPassword,
          onChanged: (value) {
            _formStore.setConfirmPassword(_confirmPasswordController.text);
          },
        );
      },
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: RoundedButtonWidget(
        width: Dimens.screenWidth(context) / 3,
        themeStore: _themeStore!,
        buttonText: AppLocalizations.of(context).translate('registerBtn'),
        buttonColor: AppColors.mainColor[300]!,
        textColor: Colors.white,
        onPressed: () async {
          //if(_passwordController.text!=_confirmPasswordController.text){
          if (_formStore.canRegister) {
            Dimens.hideKeyboard(context);
            //userDataStore!.confirmRegistration(_userEmailController.text, _passwordController.text,languageStore!.locale);
            await _userDataStore!.saveUser(new UserModel(
                email: _userEmailController.text,
                password: _passwordController.text,
                userTypeId: _userDataStore!.userType));
          } else {
            HandleWarnMessage.internal().HandleErrorMessage(
                context: context,
                title:
                    "${AppLocalizations.of(context).translate('fillFieldsError')}",
                errorMessage: _formStore.errorStore.errorMessage,
                isError: _formStore.errorStore.isError,
                themeStore: _themeStore!);
          }
          /* }else{
            _showErrorMessage(AppLocalizations.of(context)!.translate('confirmPasswordError'));

          }*/
        },
      ),
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.main, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode!.dispose();
    super.dispose();
  }
}
