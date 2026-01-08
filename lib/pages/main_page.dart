import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/image_assets.dart';
import 'package:trilhaapp/pages/list_view_horizontal.dart';
import 'package:trilhaapp/pages/tarefa_page/tarefa_sqlite_page.dart';
import 'package:trilhaapp/pages/consulta_cep.dart';
import 'package:trilhaapp/shared/widget/coston_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Meu App")),
        drawer: CustonDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: [
                  ConsultaCEP(),
                  CardPage(),
                  ImageAssetsPage(),
                  ListView(),
                  ListViewHorizontal(),
                  TarefaSQLitePage(),
                  TarefaSQLitePage(),
                ],
              ),
            ),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                controller.jumpToPage(value);
              },
              currentIndex: posicaoPagina,
              items: [
                BottomNavigationBarItem(
                  label: "HTTP",
                  icon: Icon(Icons.get_app_rounded),
                ),
                BottomNavigationBarItem(label: "Page1", icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: "Page2", icon: Icon(Icons.add)),
                BottomNavigationBarItem(
                  label: "Page3",
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: "Page4",
                  icon: Icon(Icons.image),
                ),
                BottomNavigationBarItem(
                  label: "Tarefas",
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


