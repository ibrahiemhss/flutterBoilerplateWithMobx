import 'package:flutterBoilerplateWithMobx/constants/app_theme.dart';
import 'package:flutterBoilerplateWithMobx/constants/strings.dart';
import 'package:flutterBoilerplateWithMobx/data/repository.dart';
import 'package:flutterBoilerplateWithMobx/di/components/injection.dart';
import 'package:flutterBoilerplateWithMobx/stores/chat/chat_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/fcm/firebase_messaging_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/navigation/navigation_store.dart';
import 'package:flutterBoilerplateWithMobx/ui/splash/splash.dart';
import 'package:flutterBoilerplateWithMobx/utils/routes/routes.dart';
import 'package:flutterBoilerplateWithMobx/stores/language/language_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/post/post_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/theme/theme_store.dart';
import 'package:flutterBoilerplateWithMobx/stores/user/user_store.dart';
import 'package:flutterBoilerplateWithMobx/ui/home/home.dart';
import 'package:flutterBoilerplateWithMobx/ui/login/login.dart';
import 'package:flutterBoilerplateWithMobx/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final FirebaseMessagingStore firebaseMessagingStore =
      FirebaseMessagingStore(getIt<Repository>());
  final NavigationStore navigationStore = NavigationStore(getIt<Repository>());
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final PostStore _postStore = PostStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());
  final ChatStore chatStore = ChatStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseMessagingStore>(create: (_) => firebaseMessagingStore),
        Provider<NavigationStore>(create: (_) => navigationStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<ChatStore>(create: (_) => chatStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
