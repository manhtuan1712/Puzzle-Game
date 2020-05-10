import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum Flavor { DEVELOP, RELEASE }

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.flavor,
    @required this.apiBaseUrl,
    @required Widget child,
  }) : super(child: child);

  final Flavor flavor;
  final String apiBaseUrl;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
