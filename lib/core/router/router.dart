import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guess_word_game/ui/views/detail_view.dart';
import 'package:guess_word_game/ui/views/main_view.dart';

class Router {
  static const String main = '/';
  static const String detail = 'detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => route(settings),
        settings: RouteSettings(name: settings.name));
  }

  static route(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MainView();
      case detail:
        return DetailView(question: settings.arguments);
      default:
        return Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
    }
  }
}
