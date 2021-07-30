import 'package:ecom_shop/components/custom_surffix_icon.dart';
import 'package:ecom_shop/components/default_button.dart';
import 'package:ecom_shop/components/form_error.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ForgettenEmailForm extends StatefulWidget {
  @override
  _ForgettenEmailFormState createState() => _ForgettenEmailFormState();
}

class _ForgettenEmailFormState extends State<ForgettenEmailForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailForm(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(
              // height: getProportionateScreenHeight(20),
              height: SizeConfig.screenHeight * 0.3),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
            },
          )
        ],
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
