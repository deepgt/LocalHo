import "package:flutter/material.dart";

const localhost = "to your ipv4 address like :- http://192.168.*.**:3000";
const KPrimaryColor = Color(0xFFFF7643);
const KPrimaryLightColor = Color(0xFFFFECDF);
const KPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const KSecondaryColor = Color(0xFF979797);
const KTextColor = Color(0xFF757575);

const KAnimationDuration = Duration(milliseconds: 200);

//form errors
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-z]+");
const String KEmailNullError = "please Enter Your Email";
const String KInvalidEmailError = "please Enter valid Email";
const String KpassNullError = "please Enter Your Password";
const String KShortPassError = "password is too short";
const String KMatchPassError = "password don't match";

const String KNameNullError = "please Enter Your Name";
const String KDateOfBirth = "please Enter Your Date of Birth";
