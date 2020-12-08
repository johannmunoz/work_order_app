import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:work_order_app/app/locator.dart';
import 'package:work_order_app/app/router.gr.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Order',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blue[200],
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: router.Routes.startupView,
      onGenerateRoute: router.Router(),
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
