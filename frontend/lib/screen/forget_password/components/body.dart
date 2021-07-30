import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'forgetten_password_email_form.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Text(
            "Password",
            style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "please enter your email address!",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          ForgettenEmailForm(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(fontSize: getProportionateScreenWidth(15)),
              ),
              Text(
                "Sign up",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: KPrimaryColor),
              )
            ],
          )
        ]),
      ),
    ));
  }
}
