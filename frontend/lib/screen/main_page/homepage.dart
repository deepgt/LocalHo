import 'package:ecom_shop/components/drawer.dart';
import 'package:ecom_shop/screen/main_page/components/bodycom.dart';
import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getNames() async {}

  SharedPreferences sharedPreferences;

  checkloginstatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.popAndPushNamed(context, SignInScreen.routeName);
    }
    print(sharedPreferences.getString("token"));
  }

  @override
  void initState() {
    checkloginstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("LocalHo"),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})]),
      drawer: Drawer(
        child: Drawerlist(),
      ),
      body: BodyCom(),
    );
  }
}
