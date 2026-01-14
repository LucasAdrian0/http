import 'package:flutter/material.dart';
import 'package:trilhaapp/model/variacao_de_preco.dart';
import 'package:trilhaapp/repositories/binance/endpoint_publico/binance_repository.dart';

class VariacaPrecoPage extends StatefulWidget {
  const VariacaPrecoPage({super.key});

  @override
  State<VariacaPrecoPage> createState() => _VariacaPrecoPageState();
}

class _VariacaPrecoPageState extends State<VariacaPrecoPage> {
  late BinanceVariacaoDePrecoRepository variacaoDePrecoRepository;
  //VariacaoDePrecoModel precos = VariacaoDePrecoModel();
  List<VariacaoDePrecoModel> precos = [];
  @override
  void initState() {
    // TODO: implement initState
    variacaoDePrecoRepository = BinanceVariacaoDePrecoRepository();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    precos = await variacaoDePrecoRepository.getVariacaoDePreco();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Variação de Preços das Criptomoedas")),
        body: Container(
          child: ListView.builder(
            itemCount: precos.length,
            itemBuilder: (_, int index) {
              var preco = precos[index];

              return Card(
                child: ListTile(
                  title: Text(preco.symbol ?? ''),
                  subtitle: Text("Ultimo preço: ${preco.lastPrice ?? '-'}"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
