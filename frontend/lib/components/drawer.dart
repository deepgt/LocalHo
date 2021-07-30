import 'package:ecom_shop/constants.dart';
import 'package:ecom_shop/screen/cart/cart.dart';
import 'package:ecom_shop/screen/main_page/homepage.dart';
import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:ecom_shop/screen/user_profile/user_profile_screen.dart';
import 'package:ecom_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawerlist extends StatelessWidget {
  const Drawerlist({
    Key key,
  }) : super(key: key);

  logout(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.remove("token");
    print(sharedPreferences.get("token"));
    Navigator.popAndPushNamed(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(100)),
                color: KPrimaryColor,
              ),
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(120),
            ),
          ),
        ),
        ListTile(
          title: Text('Home', textScaleFactor: 1.5),
          onTap: () {
            Navigator.popAndPushNamed(context, HomePage.routeName);
          },
        ),
        ListTile(
          title: Text('Profile', textScaleFactor: 1.5),
          onTap: () {
            Navigator.popAndPushNamed(context, UserProfile.routeName);
          },
        ),
        ListTile(
          title: Text('Cart', textScaleFactor: 1.5),
          onTap: () {
            Navigator.popAndPushNamed(context, CartPage.routeName);
          },
        ),
        ListTile(
          title: Text('Setting', textScaleFactor: 1.5),
          onTap: () {},
        ),
        ListTile(
          title: Text('About Us', textScaleFactor: 1.5),
          onTap: () {},
        ),
        ListTile(
          title: Text('Log Out', textScaleFactor: 1.5),
          onTap: () {
            logout(context);
            Navigator.popAndPushNamed(context, SignInScreen.routeName);
          },
        ),
      ],
    );
  }
}
