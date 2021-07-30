import 'package:ecom_shop/screen/main_page/components/trending.dart';
import 'package:ecom_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'home/popular_card.dart';
import 'home/recommended_card.dart';
import 'home/more_card.dart';

class Home extends StatefulWidget {
  const Home({key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 3,
              child: Container(
                height: getProportionateScreenHeight(200),
                width: double.infinity,
                child: Expanded(
                  child: SizedBox(
                    height: getProportionateScreenHeight(10),
                    child: Image.asset("assets/images/fresh.jpg"),
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
                width: double.infinity,
                child: Text(
                  "Recommanded",
                  textAlign: TextAlign.left,
                  textScaleFactor: getProportionateScreenHeight(1.8),
                )),
            Container(
              height: getProportionateScreenHeight(200),
              child: Expanded(
                child: SizedBox(
                  height: getProportionateScreenHeight(10),
                  child: RecommandedCard(),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
                width: double.infinity,
                child: Text(
                  "Popular",
                  textAlign: TextAlign.left,
                  textScaleFactor: getProportionateScreenHeight(1.8),
                )),
            Container(
              height: getProportionateScreenHeight(200),
              child: Expanded(
                child: SizedBox(
                  height: getProportionateScreenHeight(10),
                  child: PopularCard(),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
                width: double.infinity,
                child: Text(
                  "Shoes",
                  textAlign: TextAlign.left,
                  textScaleFactor: getProportionateScreenHeight(1.8),
                )),
            Container(
              height: getProportionateScreenHeight(200),
              child: Expanded(
                child: SizedBox(
                  height: getProportionateScreenHeight(10),
                  child: RecommandedCard(),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
                width: double.infinity,
                child: Text(
                  "Food",
                  textAlign: TextAlign.left,
                  textScaleFactor: getProportionateScreenHeight(1.8),
                )),
            Container(
              height: getProportionateScreenHeight(200),
              child: Expanded(
                child: SizedBox(
                  height: getProportionateScreenHeight(10),
                  child: MoreCard(),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
                width: double.infinity,
                child: Text(
                  "More",
                  textAlign: TextAlign.left,
                  textScaleFactor: getProportionateScreenHeight(1.8),
                )),
            Trending(),
          ],
        ),
      ),
    );
  }
}
