import 'dart:async';

import 'package:examen_pecano/controllers/ControllerMain.dart';
import 'package:examen_pecano/router_generator.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await GlobalConfiguration().loadFromAsset("configuration");
      runApp(App());
    },
    (error, st) => print(error),
  );
}

class App extends AppStatefulWidgetMVC {
  App({Key? key}) : super(key: key, con: MainController());
  static String? homeStateKey;

  @override
  AppStateMVC createState() => AppPage();
}

class AppPage extends AppStateMVC<App> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory AppPage() => _this ??= AppPage._();

  AppPage._() : super(controller: (MainController()));
  static AppPage? _this;

  @override
  Widget buildApp(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'COMPROBANTES PECANO',
        initialRoute: RouteName.comprobantes,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          brightness: Brightness.light,
          //primaryColorDark: Color(0xFF202B64),
          primaryColorLight: Color(0xFF0063B0),
          primaryColor: Color(0xFF0063B0),
          accentColor: Colors.blue[600],
          // hintColor: Colors.grey[350],
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            headline2: TextStyle(
              fontSize: 56.0,
            ),
            headline3: TextStyle(
              fontSize: 44.0,
            ),
            headline4: TextStyle(
              fontSize: 32.0,
            ),
            headline5: TextStyle(
              fontSize: 28.0,
            ),
            headline6: TextStyle(
              fontSize: 24.0,
            ),
            subtitle1: TextStyle(fontSize: 15.0, color: Color(0xFF84888F)),
            subtitle2: TextStyle(fontSize: 14.0, color: Color(0xFF84888F)),
            bodyText1: TextStyle(fontSize: 12.0, color: Color(0xFF84888F)),
            bodyText2: TextStyle(fontSize: 11.5, color: Color(0xFF84888F)),
          ),
        ),
      );
}
