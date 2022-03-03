import 'package:examen_pecano/view/ComprobantesView.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String comprobantes = "/comprobantes";
}

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.comprobantes:
        return MaterialPageRoute(builder: (_) => ComprobanteView());

      // case '/home':
      //   return MaterialPageRoute(builder: (_) => BasePage());

      // case '/config':
      //   return MaterialPageRoute(builder: (_) => ConfiguracionPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Text(""),
      );
      // return ScaffoldWidget(
      //   title: "404. Not Found.",
      //   canPop: true,
      //   body: Center(
      //     child: Text('404. Not Found.'),
      //   ),
      // );
    });
  }
}
