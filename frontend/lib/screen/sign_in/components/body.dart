import 'package:ecom_shop/constants.dart';
import 'package:ecom_shop/screen/sign_in/components/signin_form.dart';
import 'package:ecom_shop/screen/sign_in/components/social_card.dart';
import 'package:ecom_shop/screen/sign_up/sign_up_screen.dart';
import 'package:ecom_shop/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "welcome Back",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "sign in with your email and password \nor continue with your social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              SignForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    icon: "assets/icons/facebook_black_24dp.svg",
                    press: () {},
                  ),
                  SocialCard(
                    icon: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocialCard(
                    icon: "assets/icons/search.svg",
                    press: () {},
                  ),
                ],
              ),
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
                  GestureDetector(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: KPrimaryColor),
                    ),
                    onTap: () => Navigator.popAndPushNamed(
                        context, SignUpScreen.routeName),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
