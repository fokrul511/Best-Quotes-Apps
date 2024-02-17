import 'dart:convert';

import 'package:best_quotes/presentation/model/data.dart';
import 'package:best_quotes/presentation/widgets/pop_up_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

List<QuotesModel> quotesList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var total = 0;
  bool isLoadingScreen = false;
  int limit = 1450; // Set your desired limit here

  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [const PopUpButton()],
        centerTitle: true,
        title: const Text('Best Quotes'),
      ),
      body: Visibility(
        visible: isLoadingScreen == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: quotesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                splashColor: Colors.green,
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                        text:
                            '${quotesList[index].quoteTitle} -${quotesList[index].authorName}'),
                  ).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 500),
                          backgroundColor: Colors.green,
                          content:
                              Text('${quotesList[index].id} Copy Successfully'),
                        ),
                      );
                    },
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          quotesList[index].id.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          quotesList[index].quoteTitle ?? "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "- ${quotesList[index].authorName ?? ""}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getQuotes() async {
    isLoadingScreen = true;
    setState(() {});
    Uri url = Uri.parse('https://dummyjson.com/quotes?limit=$limit');
    Response response = await get(url);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var list = responseBody['quotes'];
      for (var item in list) {
        QuotesModel quotesModel = QuotesModel.formJson(item);
        quotesList.add(quotesModel);
      }
      setState(() {});
      isLoadingScreen = false;
      setState(() {});
    }
  }
}
