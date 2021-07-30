import 'package:ecom_shop/screen/cart/cart.dart';
import 'package:ecom_shop/screen/forget_password/forget_password_screen.dart';
import 'package:ecom_shop/screen/main_page/homepage.dart';
import 'package:ecom_shop/screen/order_page/order_page.dart';
import 'package:ecom_shop/screen/sign_in/sign_in_screen.dart';
import 'package:ecom_shop/screen/sign_up/sign_up_screen.dart';
import 'package:ecom_shop/screen/single_product/single_product.dart';
import 'package:ecom_shop/screen/splash/splash_screen.dart';
import 'package:ecom_shop/screen/user_profile/user_profile_screen.dart';
import 'package:flutter/widgets.dart';

//we use name route
//all our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  SingleProduct.routeName: (context) => SingleProduct(),
  HomePage.routeName: (context) => HomePage(),
  ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
  UserProfile.routeName: (context) => UserProfile(),
  CartPage.routeName: (context) => CartPage(),
  OrderPage.routeName: (context) => OrderPage()
};
