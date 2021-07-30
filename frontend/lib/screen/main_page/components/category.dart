import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Map mapResponse;
  // List listOfFacts;

  Future fetchapi() async {
    http.Response response;
    var url = Uri.parse("http://192.168.1.66:3000/products/incategory");
    response = await http.get(url);
    if (response.statusCode == 200) {
      mapResponse = jsonDecode(response.body);
      // listOfFacts = mapResponse['rows'];
      print(mapResponse);
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
      child: Column(
        children: [
          Text("data")
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return Container(
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 40),
          //         child: Column(
          //           children: [
          //             Text(mapResponse[index]),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          //   itemCount: mapResponse == null ? 0 : mapResponse.length,
          // )
        ],
      ),
    );
  }
}
