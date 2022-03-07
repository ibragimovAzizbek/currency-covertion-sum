import 'package:currency/screens/convertion.dart';
import 'package:currency/screens/convertion_valuta/convertion_valuta.dart';
import 'package:currency/screens/home/home_page.dart';
import 'package:flutter/material.dart';

class MyRoute {
  Route? onGenerateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/convertion':
        return MaterialPageRoute(
          builder: (_) => ConvertionPage(
            index: args as int,
          ),
        );

      case '/valuts':
        return MaterialPageRoute(builder: (_) => const ConvertionVluta());
    }
  }
}
