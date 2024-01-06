import 'package:flutter/material.dart';
import '../../presentation/history_fact_page.dart';
import '../../presentation/home_page.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String homeScreen = "/home_screen";
  static const String history = "/history";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case RouteNames.history:
        return MaterialPageRoute(
          builder: (context) => const HistoryFact(),
        );
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text("Route not found!")),
      ),
    );
  }
}
