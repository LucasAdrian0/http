// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/repositories/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widget/text_label.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({super.key});

  @override
  State<DadosCadastraisHivePage> createState() =>
      _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();

  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];

  bool salvando = false;

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i < quantidadeMaxima; i++) {
      // ignore: sort_child_properties_last
      itens.add(DropdownMenuItem(child: Text(i.toString()), value: i));
    }
    return itens;
  }

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagem();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.carregar();
    dadosCadastraisModel = dadosCadastraisRepository.obterDados();
    nomeController.text = dadosCadastraisModel.nome ?? "";
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null
        ? ""
        : dadosCadastraisModel.dataNascimento.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus dados")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ? Center(child: const CircularProgressIndicator())
            : ListView(
                children: [
                  TextLabel(texto: 'Nome'),
                  TextField(controller: nomeController),
                  TextLabel(texto: "Data de nascimento"),
                  TextField(
                    controller: dataNascimentoController,
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000, 1, 1),
                        lastDate: DateTime(2050, 12, 31),
                      );
                      if (data != null) {
                        dataNascimentoController.text = data.toString();
                        dadosCadastraisModel.dataNascimento = data;
                      } else {}
                    },
                  ),
                  const TextLabel(texto: "Nivel de experiência"),
                  Column(
                    children: niveis
                        .map(
                          (nivel) => RadioListTile(
                            dense: true,
                            title: Text(nivel.toString()),
                            selected:
                                dadosCadastraisModel.niveExperiencia == nivel,
                            value: nivel.toString(),
                            groupValue: dadosCadastraisModel.niveExperiencia,
                            onChanged: (value) {
                              // ignore: avoid_print
                              print(value);
                              setState(() {
                                dadosCadastraisModel.niveExperiencia = value
                                    .toString();
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  TextLabel(texto: 'Linguagens preferidas'),
                  Column(
                    children: linguagens
                        .map(
                          (linguagem) => CheckboxListTile(
                            dense: true,
                            title: Text(linguagem),
                            value: dadosCadastraisModel.linguagens.contains(
                              linguagem,
                            ),
                            onChanged: (bool? value) {
                              if (value!) {
                                setState(() {
                                  dadosCadastraisModel;
                                  dadosCadastraisModel.linguagens.add(
                                    linguagem,
                                  );
                                });
                              } else {
                                setState(() {
                                  dadosCadastraisModel.linguagens.remove(
                                    linguagem,
                                  );
                                });
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
                  TextLabel(texto: "Tempo de experiencia"),
                  DropdownButton(
                    value: dadosCadastraisModel.tempoExperiencia,
                    isExpanded: true,
                    items: returnItens(50),
                    onChanged: (value) {
                      setState(() {
                        dadosCadastraisModel.tempoExperiencia = int.parse(
                          value.toString(),
                        );
                      });
                    },
                  ),
                  TextLabel(
                    texto:
                        "Pretenção salarial. R\$ ${dadosCadastraisModel.salario?.round().toString()}",
                  ),
                  Slider(
                    min: 0,
                    max: 10000,
                    value: dadosCadastraisModel.salario ?? 0,
                    onChanged: (double value) {
                      setState(() {
                        dadosCadastraisModel.salario = value;
                      });
                    },
                  ),

                  TextButton(
                    onPressed: () async {
                      setState(() {
                        salvando = false;
                      });
                      if (nomeController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("O nome deve ser preenchido"),
                          ),
                        );
                        return;
                      }
                      if (dadosCadastraisModel.dataNascimento == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data de Nascimento inválida"),
                          ),
                        );
                        return;
                      }
                      if (dadosCadastraisModel.niveExperiencia == null ||
                          dadosCadastraisModel.niveExperiencia!.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("O nível dever ser selecionado"),
                          ),
                        );
                        return;
                      }
                      if (dadosCadastraisModel.linguagens.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Deve ser selecionado ao menos uma linguagem",
                            ),
                          ),
                        );
                        return;
                      }
                      if (dadosCadastraisModel.tempoExperiencia == null ||
                          dadosCadastraisModel.tempoExperiencia == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Dever ter ao menos 1 ano de experiência em uma das linguagens",
                            ),
                          ),
                        );
                        return;
                      }
                      if (dadosCadastraisModel.salario == null ||
                          dadosCadastraisModel.salario == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "A pretensão salarial deve ser maior que Zero",
                            ),
                          ),
                        );
                        return;
                      }
                      //salavar dados
                      dadosCadastraisModel.nome = nomeController.text;
                      dadosCadastraisRepository.salvar(dadosCadastraisModel);
                      setState(() {
                        salvando = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Dados salvos com sucesso"),
                          ),
                        );
                        setState(() {
                          salvando = false;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      });
                    },

                    child: Text("Salvar"),
                  ),
                ],
              ),
      ),
    );
  }
}
