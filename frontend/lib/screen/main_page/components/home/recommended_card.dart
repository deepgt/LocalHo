import 'dart:convert';
import 'package:ecom_shop/screen/single_product/single_product.dart';
import 'package:ecom_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants.dart';

class RecommandedCard extends StatefulWidget {
  const RecommandedCard({key}) : super(key: key);

  @override
  _RecommandedCardState createState() => _RecommandedCardState();
}

class _RecommandedCardState extends State<RecommandedCard> {
  var isLoadingFlag = true;
  Map mapResponse;
  List product;

  Future fetchpopularproduct() async {
    final response =
        await http.get(Uri.parse('$localhost/products/incategory/1'));

    if (response.statusCode == 200) {
      mapResponse = jsonDecode(response.body);
      product = mapResponse['rows'];
      isLoadingFlag = false;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    fetchpopularproduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: FutureBuilder(
          future: fetchpopularproduct(),
          builder: (context, snapshot) {
            if (isLoadingFlag == false) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(20)),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(20)),
                    width: getProportionateScreenWidth(150),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleProduct(),
                                settings: RouteSettings(
                                  arguments: product[index]["product_id"],
                                )));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: getProportionateScreenWidth(80),
                            height: getProportionateScreenHeight(140),
                            child: Image.network(
                              product[index]["thumbnail"],
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(30)),
                          Flexible(
                            child: Text(
                              product[index]["name"],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Rs ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(text: product[index]["price"]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: product == null ? 0 : product.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
