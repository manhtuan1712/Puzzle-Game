import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/config/app_config.dart';
import 'my_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  var configuredApp = AppConfig(
    flavor: Flavor.RELEASE,
    apiBaseUrl: 'https://.....',
    child: MyApp(),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(configuredApp);
}
