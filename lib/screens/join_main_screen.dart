import 'package:classcar/screens/certified_screen.dart';
import 'package:classcar/screens/join_screen.dart';
import 'package:classcar/screens/personal_screen.dart';
import 'package:flutter/material.dart';

class JoinMainScreen extends StatefulWidget {
  const JoinMainScreen({super.key});

  @override
  State<JoinMainScreen> createState() => _JoinMainScreenState();
}

final _navigatorKey = GlobalKey<NavigatorState>();

const routeA = "/";
const routeB = "/CertifiedScreen";
const routeC = "/PersonalScreen";

MaterialPageRoute _onGenerateRoute(RouteSettings setting) {
  if (setting.name == routeA) {
    return MaterialPageRoute<dynamic>(
        builder: (context) => JoinScreen(
            onPress: () => _navigatorKey.currentState?.pushNamed(routeB)),
        settings: setting);
  } else if (setting.name == routeB) {
    return MaterialPageRoute<dynamic>(
        builder: (context) => CertifiedScreen(
            onPress: () => _navigatorKey.currentState?.pushNamed(routeC)),
        settings: setting);
  } else if (setting.name == routeC) {
    return MaterialPageRoute<dynamic>(
        builder: (context) => const PersonalScreen(), settings: setting);
  } else {
    throw Exception('Unknown route: ${setting.name}');
  }
}

class _JoinMainScreenState extends State<JoinMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Navigator(
                key: _navigatorKey,
                initialRoute: routeA,
                onGenerateRoute: _onGenerateRoute,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
