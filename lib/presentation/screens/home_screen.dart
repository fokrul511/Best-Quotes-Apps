import 'dart:convert';

import 'package:best_quotes/app.dart';
import 'package:best_quotes/presentation/model/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

List<QuotesModel> quotesList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Best Quotes'),
      ),
      body: ListView.builder(
        itemCount: quotesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      quotesList[index].quoteTitle ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      quotesList[index].authorName ?? "",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getQuotes() async {
    Uri url = Uri.parse('https://dummyjson.com/quotes');
    Response response = await get(url);

    if (response.statusCode == 200) {
      var responsBody = jsonDecode(response.body);
      var list = responsBody['quotes'];
      for (var item in list) {
        QuotesModel quotesModel = QuotesModel.formJson(item);
        quotesList.add(quotesModel);
      }
      setState(() {});
    }
  }
}
