import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/tarefas_back4app_repository.dart';

class TarefaHttpPage extends StatefulWidget {
  const TarefaHttpPage({super.key});

  @override
  State<TarefaHttpPage> createState() => _TarefaHttpPageState();
}

class _TarefaHttpPageState extends State<TarefaHttpPage> {
  TarefasBack4appRepository tarefaRepository = TarefasBack4appRepository();
  var _tarefasBack4app = TarefasBack4AppModel([]);
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      carregando = true;
    });
    _tarefasBack4app = await tarefaRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas HTTP")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          descricaoController.text = "";
          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                title: const Text("Adicionar tarefa"),
                content: TextField(controller: descricaoController),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await tarefaRepository.criar(
                        TarefaBack4AppModel.criarTarefas(
                          descricaoController.text,
                          false,
                        ),
                      );
                      Navigator.pop(context);
                      obterTarefas();
                      setState(() {});
                    },
                    child: Text("Salvar"),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Apenas não concluidos",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: apenasNaoConcluidos,
                    onChanged: (bool value) {
                      apenasNaoConcluidos = value;
                      obterTarefas();
                    },
                  ),
                ],
              ),
            ),
            carregando
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _tarefasBack4app.tarefas.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var tarefa = _tarefasBack4app.tarefas[index];
                        return Dismissible(
                          onDismissed:
                              (DismissDirection dismissDerection) async {
                               await tarefaRepository.remover(tarefa.objectId);
                                obterTarefas();
                              },
                          key: Key(tarefa.descricao),
                          child: ListTile(
                            title: Text(tarefa.descricao),
                            trailing: Switch(
                              onChanged: (bool value) async {
                                tarefa.concluido = value;
                                await tarefaRepository.atualizar(tarefa);
                                obterTarefas();
                              },
                              value: tarefa.concluido,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
