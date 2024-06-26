import 'package:flutter/material.dart';
import 'package:plantist_project/views/home/view/home_view.dart';

class NavigationRoute {
  NavigationRoute._init();

  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {

      default:
        return MaterialPageRoute(
          builder: (context) => MyHomePage(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName, {Object? data}) {
    return MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName, arguments: data),
    );
  }
}
