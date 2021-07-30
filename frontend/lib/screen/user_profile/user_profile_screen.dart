import 'dart:convert';
import 'package:ecom_shop/components/drawer.dart';
import 'package:ecom_shop/constants.dart';
import 'package:ecom_shop/screen/cart/cart.dart';
import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:ecom_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({key}) : super(key: key);
  static String routeName = "/userprofile";
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String token;
  Map userinfo;

  var isloadingflag = true;

  checkloginstatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.popAndPushNamed(context, SignInScreen.routeName);
    } else {
      token = sharedPreferences.getString("token");
      getuserprofile(token);
    }
  }

  logout(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.remove("token");
    print(sharedPreferences.get("token"));
    Navigator.popAndPushNamed(context, SignInScreen.routeName);
  }

  Future getuserprofile(String token) async {
    http.Response response;
    var url = Uri.parse("$localhost/customer");
    response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      userinfo = jsonDecode(response.body);
      setState(() {
        isloadingflag = false;
      });
      return userinfo;
    } else {
      print(response);
    }
  }

  @override
  void initState() {
    checkloginstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Drawerlist(),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getuserprofile(token),
          builder: (context, snapshot) {
            if (isloadingflag == false && snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      width: getProportionateScreenWidth(340),
                      height: getProportionateScreenHeight(60),
                      child: Row(
                        children: [
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Icon(
                            Icons.email,
                            color: KPrimaryColor,
                            size: getProportionateScreenHeight(30),
                          ),
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Text(snapshot.data["email"], textScaleFactor: 1.3),
                          SizedBox(width: getProportionateScreenWidth(30)),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      width: getProportionateScreenWidth(340),
                      height: getProportionateScreenHeight(60),
                      child: Row(
                        children: [
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Icon(
                            Icons.person,
                            color: KPrimaryColor,
                            size: getProportionateScreenHeight(30),
                          ),
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Text(snapshot.data["name"], textScaleFactor: 1.3),
                          SizedBox(width: getProportionateScreenWidth(30)),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      width: getProportionateScreenWidth(340),
                      height: getProportionateScreenHeight(60),
                      child: Row(
                        children: [
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Icon(
                            Icons.place,
                            color: KPrimaryColor,
                            size: getProportionateScreenHeight(30),
                          ),
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Text("testaddress", textScaleFactor: 1.3),
                          SizedBox(width: getProportionateScreenWidth(30)),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      width: getProportionateScreenWidth(340),
                      height: getProportionateScreenHeight(60),
                      child: Row(
                        children: [
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Icon(
                            Icons.shopping_cart,
                            color: KPrimaryColor,
                            size: getProportionateScreenHeight(30),
                          ),
                          SizedBox(width: getProportionateScreenWidth(30)),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CartPage.routeName);
                              },
                              child: Text('your cart', textScaleFactor: 1.3)),
                          SizedBox(width: getProportionateScreenWidth(30)),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      width: getProportionateScreenWidth(340),
                      height: getProportionateScreenHeight(60),
                      child: Row(
                        children: [
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Icon(
                            Icons.logout,
                            color: KPrimaryColor,
                            size: getProportionateScreenHeight(30),
                          ),
                          SizedBox(width: getProportionateScreenWidth(30)),
                          GestureDetector(
                              onTap: () {
                                logout(context);
                                Navigator.popAndPushNamed(
                                    context, SignInScreen.routeName);
                              },
                              child: Text('logout', textScaleFactor: 1.3)),
                          SizedBox(width: getProportionateScreenWidth(30)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("oh on something is wrong!"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
