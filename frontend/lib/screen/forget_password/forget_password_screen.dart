import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/forget_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () =>
              Navigator.popAndPushNamed(context, SignInScreen.routeName),
        ),
        centerTitle: true,
        title: Text("forget password"),
      ),
      body: Body(),
    );
  }
}
