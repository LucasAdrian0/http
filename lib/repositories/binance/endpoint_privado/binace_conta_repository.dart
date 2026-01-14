import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BinanceAccountRepository {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getAccount() async {
    final publicKey = dotenv.env['BINANCEPUBLICAPIKEY']!;
    final privateKey = dotenv.env['BINANCEAPIKEY']!;

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final query = 'timestamp=$timestamp&recvWindow=5000';
    final signature = _sha256(query, privateKey);

    final response = await dio.get(
      'https://api.binance.com/api/v3/account?$query&signature=$signature',
      options: Options(
        headers: {'X-MBX-APIKEY': publicKey},
      ),
    );

    return response.data;
  }

  String _sha256(String query, String secret) {
    final key = utf8.encode(secret);
    final bytes = utf8.encode(query);
    final hmac = crypto.Hmac(crypto.sha256, key);
    return hmac.convert(bytes).toString();
  }
}
