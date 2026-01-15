import 'package:dio/dio.dart';
import 'package:trilhaapp/model/tarefas_back4app_model.dart';

class TarefasBack4appRepository {
  Future<TarefasBack4AppModel> obterTarefas() async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "WIigcYdfkNFLgun2vsR6EIHOsMPJrCg1ebtNZ7Zi";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "XVUWP1n0HqRK0eP4exGIMju3QL1k1hkLy5cDmpGc";
    dio.options.headers["Content-Type"] = "application/json";
    var result = await dio.get('https://parseapi.back4app.com/classes/Tarefas');
    return TarefasBack4AppModel.fromJson(result.data);
  }
}
