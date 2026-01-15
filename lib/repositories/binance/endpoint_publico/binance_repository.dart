import 'package:dio/dio.dart';
import 'package:trilhaapp/model/variacao_de_preco.dart';

class BinanceVariacaoDePrecoRepository {
  Future<List<VariacaoDePrecoModel>> getVariacaoDePreco() async {
    var dio = Dio();

    //********************este são dados relacionados ao curso não a API que estou utilizando************************
    //var ts = DateTime.now().microsecondsSinceEpoch.toString();
    // var publicKey = dotenv.get("BINANCEPUBLICAPIKEY");
    // var privatekey = dotenv.get("BINANCEAPIKEY");
    // var hash = _generateMd5(ts + privatekey + publicKey);
    // var query = "?ts=$ts&apikey=$publicKey&hash=$hash";
    //API da Binance não utiliza md5 e sim SHA256

    //Variação de preço Binance de todas criptomoedas
    var response = await dio.get(
      'https://api.binance.com/api/v3/ticker/24hr',
    );
    return (response.data as List)
        .map((e) => VariacaoDePrecoModel.fromJson(e))
        .toList();
  }

  
}
  //********************este são dados relacionados ao curso não a API que estou utilizando************************
  // _generateMd5(String data) {
  //   var content = new Utf8Encoder().convert(data);
  //   var md5 = crypto.md5;
  //   var digest = md5.convert((content));
  //   return hex.encode(digest.bytes);
  // }
//}
