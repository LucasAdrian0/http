import 'package:trilhaapp/model/tarefa_sqlite_model.dart';
import 'package:trilhaapp/repositories/sqlite/sqlite_database.dart';

class TarefaSQLiteRepositiry {
  Future<List<TarefaSQLiteModel>> obterDados() async {
    List<TarefaSQLiteModel> tarefas = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = db.rawQuery('SELECT id, descricao, concluido FROM tarefas');
    for (var element in result) {
      tarefas.add(
        TarefaSQLiteModel(
          int.parse(element["id"].toString()),
          element["descricao"].toString(),
          element["concluido"] == "1",
        ),
      );
    }
    return tarefas;
  }

  Future<void> Salvar(TarefaSQLiteModel tarefaSQLiteModel) async {
    var db = await SQLiteDataBase().obterDataBase();
  }
}
