import 'dart:convert';
import 'dart:io';
import 'package:ecom_shop/constants.dart';
import 'package:ecom_shop/screen/main_page/components/home/recommended_card.dart';
import 'package:ecom_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingleProduct extends StatefulWidget {
  static String routeName = "/SingleProductpage";

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  var isLoadingFlag = true;
  Map product;
  String cartid;
  // Map tempid;
  String colorAttr = "black";

  Future fetchproduct(context) async {
    int productid = ModalRoute.of(context).settings.arguments;

    final response =
        await http.get(Uri.parse('$localhost/products/$productid'));

    if (response.statusCode == 200) {
      product = jsonDecode(response.body);
      print(product);
      isLoadingFlag = false;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future getcartid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      cartid = sharedPreferences.getString("cartid");
    });
  }

  Future addtocart(productid, cartid) async {
    final response = await http.post(
      Uri.parse('$localhost/shoppingcart/add'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(
        {"cart_id": cartid, "product_id": productid, "attributes": colorAttr},
      ),
    );
    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        content: Text('the product has been added to cart!'),
      );
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("failed to add product");
    }
  }

  @override
  void initState() {
    getcartid();
    fetchproduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("detail page"),
      ),
      body: Center(
        child: FutureBuilder(
            future: fetchproduct(context),
            builder: (context, snapshot) {
              if (isLoadingFlag == false) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      children: [
                        productimage(product["image"], product["image_2"],
                            product["thumbnail"]),
                        Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(20)),
                            height: 180,
                            child: Stack(
                              children: [
                                Positioned(left: 10, child: Text("Price:")),
                                Positioned(
                                    left: 80, child: Text(product["price"])),
                                Positioned(
                                    top: 20, left: 10, child: Text("Name:")),
                                Positioned(
                                    top: 20,
                                    left: 80,
                                    child: Text(product["name"])),
                                Positioned(
                                    top: 40,
                                    left: 10,
                                    child: Text("descriptions:")),
                                Positioned(
                                    top: 60,
                                    left: 10,
                                    child: Container(
                                        width: getProportionateScreenWidth(300),
                                        child: Text(product["description"]))),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: Row(
                            children: [
                              SizedBox(width: getProportionateScreenWidth(20)),
                              Text("Color:"),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    colorAttr = "black";
                                    print(colorAttr);
                                  });
                                },
                                child: Text("Black"),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    colorAttr = "white";
                                  });
                                },
                                child: Text("White"),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Positioned(
                                child: GestureDetector(
                                  onTap: () {
                                    addtocart(product["product_id"], cartid);
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
                                            width:
                                                getProportionateScreenWidth(10),
                                          ),
                                          Text("Add to cart",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Icon(
                                              Icons.add_shopping_cart_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: getProportionateScreenHeight(40),
                          child: Positioned(
                            child: Text(
                              "Related",
                              textScaleFactor: 1.5,
                            ),
                          ),
                        ),
                        Container(
                          height: getProportionateScreenHeight(200),
                          child: Expanded(
                            child: SizedBox(
                              height: getProportionateScreenHeight(10),
                              child: RecommandedCard(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

productimage(product, product2, product3) {
  final PageController controller = PageController(initialPage: 0);
  return Container(
    height: getProportionateScreenHeight(300),
    child: PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: [
        Image.network(product, fit: BoxFit.contain),
        Image.network(product2, fit: BoxFit.contain),
        Image.network(product3, fit: BoxFit.contain),
      ],
    ),
  );
}
