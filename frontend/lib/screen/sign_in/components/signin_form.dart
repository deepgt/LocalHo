import 'dart:convert';
import 'dart:io';

import 'package:ecom_shop/components/custom_surffix_icon.dart';
import 'package:ecom_shop/components/default_button.dart';
import 'package:ecom_shop/components/form_error.dart';
import 'package:ecom_shop/screen/forget_password/forget_password_screen.dart';
import 'package:ecom_shop/screen/main_page/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];

  String cartid;
  Map tempid;

  checkloginstatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.popAndPushNamed(context, HomePage.routeName);
    }
  }

  Future getcartid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$localhost/shoppingcart/generateUniqueId'));
    if (response.statusCode == 200) {
      tempid = jsonDecode(response.body);
      cartid = tempid["cart_id"];
      sharedPreferences.setString("cartid", cartid);
    } else {
      throw Exception('Failed to get cart id');
    }
  }

  Future signup(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData;
    var url = Uri.parse('$localhost/customer/login');
    var response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({"email": email, "password": password}));
    if (response.statusCode == 200) {
      getcartid();
      jsonData = jsonDecode(response.body);
      sharedPreferences.setString("token", jsonData["accessToken"]);
      Navigator.popAndPushNamed(context, HomePage.routeName);
    } else {
      print(response.body);
    }
  }

  @override
  void initState() {
    checkloginstatus();
    getcartid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailForm(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordForm(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: KPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                child: Text(
                  "Forget Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onTap: () => Navigator.popAndPushNamed(
                    context, ForgetPasswordScreen.routeName),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
              signup(email, password);
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordForm() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(KpassNullError)) {
          setState(() {
            errors.remove(KpassNullError);
          });
        } else if (value.length >= 8 && errors.contains(KShortPassError)) {
          setState(() {
            errors.remove(KShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(KpassNullError)) {
          setState(() {
            errors.add(KpassNullError);
          });
        } else if (value.length < 8 && !errors.contains(KShortPassError)) {
          setState(() {
            errors.add(KShortPassError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/lock_black_24dp.svg",
        ),
      ),
    );
  }

  TextFormField buildEmailForm() {
    return TextFormField(
      onSaved: (newValue) => email = newValue,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(KEmailNullError)) {
          setState(() {
            errors.remove(KEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(KInvalidEmailError)) {
          setState(() {
            errors.remove(KInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(KEmailNullError)) {
          setState(() {
            errors.add(KEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(KInvalidEmailError)) {
          setState(() {
            errors.add(KInvalidEmailError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/email_black_24dp.svg",
        ),
      ),
    );
  }
}
