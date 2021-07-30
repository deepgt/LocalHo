import 'dart:convert';
import 'package:ecom_shop/screen/single_product/single_product.dart';
import 'package:ecom_shop/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Trending extends StatefulWidget {
  const Trending({key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  Map mapResponse;
  List listOfFacts;
  var isLoadingFlag = true;

  Future fetchapi() async {
    http.Response response;
    var url = Uri.parse("$localhost/products/");
    response = await http.get(url);
    if (response.statusCode == 200) {
      mapResponse = jsonDecode(response.body);
      listOfFacts = mapResponse['rows'];
      setState(() {
        isLoadingFlag = false;
      });
    }
  }

  @override
  void initState() {
    fetchapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: fetchapi(),
        builder: (context, snapshot) {
          if (isLoadingFlag == false) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Card(
                          elevation: 4,
                          child: Flexible(
                            child: ListTile(
                              minVerticalPadding:
                                  getProportionateScreenHeight(20),
                              title: Text(
                                listOfFacts[index]["name"],
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  text: 'Rs ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: listOfFacts[index]["price"]),
                                  ],
                                ),
                              ),
                              trailing:
                                  Image.network(listOfFacts[index]["image"]),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleProduct(),
                                        settings: RouteSettings(
                                          arguments: listOfFacts[index]
                                              ["product_id"],
                                        )));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: listOfFacts == null ? 0 : listOfFacts.length,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
