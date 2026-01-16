import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4appCustonDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4appCustonDio() {
    _dio.options.headers["X-Parse-Application-Id"] = dotenv.get(
      "BACKFORAPPAPLICARIONID",
    );
    _dio.options.headers["X-Parse-REST-API-Key"] = dotenv.get(
      "BACKFORAPPRESTAPIKEY",
    );
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACKFORAPPBASEURL");
  }
}
