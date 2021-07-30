import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/signup";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign up"),
        leading: BackButton(
          onPressed: () =>
              Navigator.popAndPushNamed(context, SignInScreen.routeName),
        ),
      ),
      body: Body(),
    );
  }
}
