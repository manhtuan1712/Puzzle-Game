import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/config/app_config.dart';
import 'my_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  var appId;
  if (Platform.isAndroid) {
    appId = "ca-app-pub-6520088554628140~2903609441";
  } else {
    appId = "ca-app-pub-6520088554628140~3658094392";
  }
  FirebaseAdMob.instance.initialize(appId: appId);
  var configuredApp = AppConfig(
    flavor: Flavor.RELEASE,
    apiBaseUrl: '',
    child: MyApp(),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(configuredApp);
}
