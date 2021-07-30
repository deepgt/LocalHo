import 'dart:convert';
import 'package:ecom_shop/screen/main_page/homepage.dart';
import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:ecom_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var isLoadingFlag = true;
  String cartid;
  List orderid;
  List orderlist;
  String token;

  checkloginstatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.popAndPushNamed(context, SignInScreen.routeName);
    } else {
      token = sharedPreferences.getString("token");
      getcartid();
    }
  }

  Future getcartid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      cartid = sharedPreferences.getString("cartid");
    });
    createorder();
  }

  Future fetchorder(orderid) async {
    final response = await http.get(Uri.parse('$localhost/order/1'));
    if (response.statusCode == 200) {
      orderlist = jsonDecode(response.body);
      isLoadingFlag = false;
      // print(orderlist);
      return orderlist;
    } else {
      // throw Exception('Failed to load');
      print("something wrong!");
    }
  }

  Future createorder() async {
    http.Response response;
    var url = Uri.parse("$localhost/order");
    response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"cart_id": cartid, "shipping_id": 1, "tax_id": 2}));
    if (response.statusCode == 200) {
      orderid = jsonDecode(response.body);
      print(orderid);
      fetchorder(orderid);
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
    return Center(
        child: FutureBuilder(
            future: fetchorder(orderid),
            builder: (context, snapshot) {
              if (isLoadingFlag == false) {
                return Card(
                  elevation: 4,
                  child: Container(
                    width: getProportionateScreenWidth(300),
                    height: getProportionateScreenHeight(600),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text("order id:", textScaleFactor: 1.1),
                                  Text(
                                      (snapshot.data[0]["order_id"]).toString(),
                                      textScaleFactor: 1.1),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("created on:", textScaleFactor: 1.1),
                                  Text(
                                      snapshot.data[0]["created_on"].toString(),
                                      textScaleFactor: 1.1),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("customer_id:", textScaleFactor: 1.1),
                                  Text(
                                      snapshot.data[0]["customer_id"]
                                          .toString(),
                                      textScaleFactor: 1.1),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("shipping cost:", textScaleFactor: 1.1),
                                  Text(
                                      snapshot.data[0]["shipping_cost"]
                                          .toString(),
                                      textScaleFactor: 1.1),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("taxes:", textScaleFactor: 1.1),
                                  Text(snapshot.data[0]["tax_type"],
                                      textScaleFactor: 1.1),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("tax percentage", textScaleFactor: 1.1),
                                  Text(
                                      snapshot.data[0]["tax_percentage"]
                                          .toString(),
                                      textScaleFactor: 1.1),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("total amount:", textScaleFactor: 1.1),
                                  Text(
                                      snapshot.data[0]["total_amount"]
                                          .toString(),
                                      textScaleFactor: 1.1),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            width: double.infinity,
                            height: getProportionateScreenHeight(56),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: KPrimaryColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, HomePage.routeName);
                              },
                              child: Text(
                                "ok",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(18)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("oh no something went wrong!");
              }
              return CircularProgressIndicator();
            }));
  }
}
