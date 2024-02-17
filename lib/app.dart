import 'dart:convert';

import 'package:best_quotes/full_image.dart';
import 'package:best_quotes/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Product> productList = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Apps'),
      ),
      body: GridView.builder(
        itemCount: productList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 3 / 4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullImage(image: productList[index].image ?? ""),
                ),
              );
            },
            child: Card(
              child: Image(
                image: NetworkImage(productList[index].image.toString()),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getApi() async {
    Uri url = Uri.parse(
        'https://api.slingacademy.com/v1/sample-data/photos?limit=132');
    Response response = await get(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      var responsBody = jsonDecode(response.body);
      var list = responsBody['photos'];
      for (var item in list) {
        Product product = Product.fromJson(item);
        productList.add(product);
      }
    }
    setState(() {});
  }
}
