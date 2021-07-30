import 'dart:convert';
import 'dart:io';
import 'package:ecom_shop/components/custom_surffix_icon.dart';
import 'package:ecom_shop/components/default_button.dart';
import 'package:ecom_shop/components/form_error.dart';
import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String name;
  String address;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        buildEmailForm(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildPasswordForm(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildRePasswordForm(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildNameForm(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildAddressForm(),
        SizedBox(height: getProportionateScreenHeight(30)),
        FormError(errors: errors),
        SizedBox(height: getProportionateScreenHeight(20)),
        DefaultButton(
          text: "continue",
          press: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
            }
            register(name, email, password, address, context);
          },
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
      ]),
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

  TextFormField buildRePasswordForm() {
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
        hintText: "Re-Enter your Password",
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

  TextFormField buildNameForm() {
    return TextFormField(
        onSaved: (newValue) => name = newValue,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              errors.remove(KNameNullError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(KNameNullError)) {
            setState(() {
              errors.add(KNameNullError);
            });
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Name",
          hintText: "Enter your Name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(20)),
            child: Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
          ),
        ));
  }

  TextFormField buildAddressForm() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      keyboardType: TextInputType.streetAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            errors.remove(KNameNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(KNameNullError)) {
          setState(() {
            errors.add(KNameNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: Icon(
            Icons.place_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

Future register(name, email, password, address, context) async {
  var jsonData;
  var url = Uri.parse('$localhost/customer/register');
  var response = await http.post(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
        "name": name,
        "address_1": address
      }));
  if (response.statusCode == 200) {
    jsonData = jsonDecode(response.body);
    Navigator.popAndPushNamed(context, SignInScreen.routeName);
  }
}
