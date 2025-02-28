import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telas_testes/screens/confirmar_compra_view.dart';
import 'package:telas_testes/viewmodel/home_viewmodel.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final homeModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Cinefilm'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: homeModel.homeModel.itens.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        homeModel.mudarEscolha(index);
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chair,
                              color:
                                  homeModel.homeModel.escolhidos[index]
                                      ? Colors.amber
                                      : Colors.white,
                            ),
                            Text('${homeModel.homeModel.itens[index]}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      homeModel.homeModel.escolhidos.isEmpty
                          ? Colors.white
                          : Colors.amber,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ConfirmarCompraView()),
                  );
                },
                child: Text(
                  homeModel.homeModel.escolhidos.isEmpty
                      ? 'Selecione pelo menos um ingresso'
                      : "Confirmar a compra de ${homeModel.homeModel.quantidadeDeEscolhidos.length} ingressos",
                  style: TextStyle(
                    color:
                        homeModel.homeModel.escolhidos.isEmpty
                            ? Colors.black
                            : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
