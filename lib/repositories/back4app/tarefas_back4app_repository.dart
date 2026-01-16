import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhaapp/model/tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/back4App_custon_dio.dart';

class TarefasBack4appRepository {
  final _custonDio = Back4appCustonDio();

  TarefasBack4appRepository();

  Future<TarefasBack4AppModel> obterTarefas(bool naoConcluidas) async {
    var url = "/Tarefas";
    if (naoConcluidas) {
      url = "$url?where={\"concluido\":false}";
    }
    var result = await _custonDio.dio.get(url);
    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criar(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _custonDio.dio.post(
        '/Tarefas',
        data: tarefaBack4AppModel.toJsonEndpoint(),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizar(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _custonDio.dio.put(
        '/Tarefas/${tarefaBack4AppModel.objectId}',
        data: tarefaBack4AppModel.toJsonEndpoint(),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custonDio.dio.delete('/Tarefas/$objectId');
    } catch (e) {
      throw e;
    }
  }
}
