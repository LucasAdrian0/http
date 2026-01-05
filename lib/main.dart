import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: ''' CREAT TABLE taredas(
        id INT PRIMARY KEY AUTOINCREMENT,
        descricao TEXT,
        concluido INTERGER
        );''',
};

//metodo para inicializar o banco de dados
Future iniciarBancoDeDados() async {
  var db = await openDatabase(
    path.join(await getDatabasesPath(), 'database.db'),
    version: scripts.length,
    onCreate: (Database db, int version) async {
      for (var i = 1; i < scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion; i < scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    },
  );
  return db;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider
      .getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());
  await iniciarBancoDeDados();
  runApp(const MyApp());
}

// iniciar video de "Organizando o Projeto"
