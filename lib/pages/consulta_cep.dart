import 'package:flutter/material.dart';
import 'package:trilhaapp/model/viacep_model.dart';
import 'package:trilhaapp/repositories/via_cep_repository.dart';

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({super.key});

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = ViaCEPModel();
  var viaCEPRepository = ViaCepRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text("Consulta de CEP", style: TextStyle(fontSize: 22)),
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                //maxLength: 8,
                onChanged: (String value) async {
                  var cep = value.replaceAll(new RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {
                      loading = false;
                    });
                    viacepModel = await viaCEPRepository.consultaCEP(cep);
                  }
                },
              ),
              SizedBox(height: 50),
              Text(
                viacepModel.logradouro ?? "",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 50),
              Text(
                "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
                style: TextStyle(fontSize: 22),
              ),

              if (loading) CircularProgressIndicator(),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {},
        ),
      ),
    );
  }
}
