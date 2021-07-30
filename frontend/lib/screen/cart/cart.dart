import 'dart:convert';
import 'package:ecom_shop/constants.dart';
import 'package:ecom_shop/screen/order_page/order_page.dart';
import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../size_config.dart';

class CartPage extends StatefulWidget {
  const CartPage({key}) : super(key: key);
  static String routeName = "/cartpage";
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List listCart;
  String cartid;
  bool isLoadingFlag = false;
  List product;

  Future getTotal() async {
    double cartTotal = 0;
    http.Response response;
    var url = Uri.parse('$localhost/shoppingCart/$cartid');
    response = await http.get(url);
    if (response.statusCode == 200) {
      listCart = jsonDecode(response.body);
      for (var i = 0; i < listCart.length; i++) {
        cartTotal += double.parse(listCart[i]["sub_total"]);
      }
      return cartTotal;
    } else {
      print(response.body);
    }
  }

  Future getcart() async {
    http.Response response;
    var url = Uri.parse("$localhost/shoppingCart/$cartid");
    response = await http.get(url);
    if (response.statusCode == 200) {
      listCart = jsonDecode(response.body);
      return listCart;
    } else {
      print(response.body);
    }
  }

  Future deleleCart() async {
    http.Response response;
    var url = Uri.parse("$localhost/shoppingCart/empty/$cartid");
    response = await http.delete(url);
    if (response.statusCode == 200) {
      print("suceessful");
    } else {
      print(response.body);
    }
  }

  removeCartItem(itemid) async {
    http.Response response;
    var url = Uri.parse("$localhost/shoppingCart/removeProduct/$itemid");
    response = await http.delete(url);
    if (response.statusCode == 200) {
      print("suceessful");
    } else {
      print(response.body);
    }
  }

  checkloginstatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.popAndPushNamed(context, SignInScreen.routeName);
    }
    setState(() {
      cartid = sharedPreferences.getString("cartid");
    });
    getcart();
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
        title: Text("Your Cart"),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerEnd,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        deleleCart();
                      },
                      child: Card(
                        color: KPrimaryColor,
                        elevation: 4,
                        child: Container(
                          width: getProportionateScreenWidth(100),
                          height: getProportionateScreenHeight(40),
                          child: Row(
                            children: [
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              Text("Remove all",
                                  style: TextStyle(color: Colors.white)),
                              Icon(Icons.delete)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: getcart(),
                    builder: (context, snapshot) {
                      if (isLoadingFlag == false) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Card(
                                    elevation: 4,
                                    child: Container(
                                      width: getProportionateScreenWidth(350),
                                      height: getProportionateScreenHeight(100),
                                      child: Flexible(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 35,
                                              left: 30,
                                              child: Text(
                                                snapshot.data[index]["name"],
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Positioned(
                                                top: 35,
                                                left: 220,
                                                child: Icon(Icons.add_circle)),
                                            Positioned(
                                                top: 35,
                                                left: 260,
                                                child: Text(snapshot.data[index]
                                                        ["quantity"]
                                                    .toString())),
                                            Positioned(
                                                top: 35,
                                                left: 280,
                                                child:
                                                    Icon(Icons.remove_circle)),
                                            Positioned(
                                              top: 37,
                                              left: 320,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Rs ',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            snapshot.data[index]
                                                                ["sub_total"]),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              // onTap: removeCartItem(
                                              //     snapshot.data[index]["itemid"]),
                                              child: Positioned(
                                                left: 380,
                                                child: Icon(
                                                  Icons.cancel_outlined,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: listCart == null ? 0 : listCart.length);
                      } else if (snapshot.hasError) {
                        Center(child: Text("something's wrong!"));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: getProportionateScreenHeight(100),
              child: Row(
                children: [
                  Positioned(top: 35, left: 90, child: Text("Total amount:")),
                  Container(
                      child: FutureBuilder(
                          future: getTotal(),
                          builder: (context, snapshot) {
                            if (isLoadingFlag == false) {
                              return Positioned(
                                top: 35,
                                left: 90,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Rs ',
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(text: snapshot.data.toString()),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          })),
                  Spacer(),
                  Stack(
                    children: [
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, OrderPage.routeName);
                          },
                          child: Card(
                            color: KPrimaryColor,
                            elevation: 4,
                            child: Container(
                              width: getProportionateScreenWidth(140),
                              height: getProportionateScreenHeight(40),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: getProportionateScreenWidth(10),
                                  ),
                                  Text("confirm purchase",
                                      style: TextStyle(color: Colors.white)),
                                  Icon(Icons.bookmark_border_outlined)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
