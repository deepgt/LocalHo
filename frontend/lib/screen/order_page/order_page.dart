import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({key}) : super(key: key);
  static String routeName = "/orderpage";

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("order page"),
      ),
      body: Body(),
    );
  }
}
