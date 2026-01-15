import 'package:flutter/material.dart';
import 'package:trilhaapp/model/variacao_de_preco.dart';
import 'package:trilhaapp/repositories/binance/endpoint_publico/binance_repository.dart';

class VariacaPrecoPage extends StatefulWidget {
  const VariacaPrecoPage({super.key});

  @override
  State<VariacaPrecoPage> createState() => _VariacaPrecoPageState();
}

class _VariacaPrecoPageState extends State<VariacaPrecoPage> {
  ScrollController _scrollController = ScrollController();
  late BinanceVariacaoDePrecoRepository variacaoDePrecoRepository;
  //VariacaoDePrecoModel precos = VariacaoDePrecoModel();
  List<VariacaoDePrecoModel> precos = [];
  var carregando = false;
  @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > posicaoParaPaginar) {
        carregarDados();
      }
    });
    // TODO: implement initState
    variacaoDePrecoRepository = BinanceVariacaoDePrecoRepository();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    if (carregando) return;
    precos = await variacaoDePrecoRepository.getVariacaoDePreco();
    setState(() {
      carregando = true;
    });
    carregando = false;
  }

  int retornQuantidadeTotal() {
    try {
      return precos.length;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Preços das ${precos.length} Criptomoedas")),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
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
            !carregando
                ? ElevatedButton(
                    onPressed: () {
                      carregarDados();
                    },
                    child: Text("Carregar mais itens"),
                  )
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
