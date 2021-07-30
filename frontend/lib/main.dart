import 'package:ecom_shop/theme.dart';
import 'routs.dart';
import 'screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: Home(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
