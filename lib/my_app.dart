import 'package:flutter/material.dart';
import 'package:guess_word_game/core/models/question.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/router/router.dart';
import 'core/services/connectivity_service.dart';
import 'core/translation/app_translations_delegate.dart';
import 'core/translation/application.dart';

class MyApp extends StatefulWidget {
  final String launchScreen;

  const MyApp({Key key, this.launchScreen}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: Locale('vi'));
    application.onLocaleChanged = onLocaleChange;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConnectivityService>(
            create: (context) => ConnectivityService()),
        ChangeNotifierProvider<Question>(
            create: (context) => Question())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Router.main,
        onGenerateRoute: Router.generateRoute,
        localizationsDelegates: [
          _newLocaleDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en", ""),
          const Locale("vi", ""),
        ],
      ),
    );
  }
}
