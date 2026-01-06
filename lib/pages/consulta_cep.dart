import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({super.key});

  @override
  State<ConsultaCEP> createState() => _ConsultaCEP();
}

class _ConsultaCEP extends State<ConsultaCEP> {
  var cepController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text("Consulta de CEP", style: TextStyle(fontSize: 22)),
              TextField(controller: cepController,),
            ],
          ),
        ),

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
