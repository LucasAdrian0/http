import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpTestPage extends StatefulWidget {
  const HttpTestPage({super.key});

  @override
  State<HttpTestPage> createState() => _HttpTestPageState();
}

class _HttpTestPageState extends State<HttpTestPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            var response = await http.get(Uri.parse('https://www.google.com'));
            print(response.body);
          },
        ),
      ),
    );
  }
}
