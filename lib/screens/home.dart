import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telas_testes/screens/confirmar_compra_view.dart';
import 'package:telas_testes/viewmodel/home_viewmodel.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool assentosVisivel = false;
  List<dynamic> ocupados = [];
  @override
  Widget build(BuildContext context) {
    final homeModel = context.watch<HomeViewModel>();
    String frase = 'ingresso';

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
                    int revertendoIndex =
                        homeModel.homeModel.itens.length - 1 - index;
                    return GestureDetector(
                      onTap: () {
                        if (!ocupados.contains(revertendoIndex)) {
                          homeModel.mudarEscolha(revertendoIndex);
                        }
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              ocupados.contains(revertendoIndex)
                                  ? Icons.person_off_outlined
                                  : Icons.chair,
                              color:
                                  homeModel
                                          .homeModel
                                          .escolhidos[revertendoIndex]
                                      ? Colors.amber
                                      : Colors.white,
                            ),
                            Visibility(
                              visible: assentosVisivel,
                              child: Text(
                                '${homeModel.homeModel.itens[revertendoIndex]}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 57, 64, 68),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 50,
                      height: 20,
                      child: Text(
                        'TELA',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SwitchListTile(
                      activeColor: Colors.green,
                      title: Text(
                        'Exibir número dos assentos',
                        style: TextStyle(fontSize: 15),
                      ),
                      value: assentosVisivel,
                      onChanged: (bool newValue) {
                        setState(() {
                          assentosVisivel = !assentosVisivel;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text('Disponível'),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.amber,
                              ),
                              SizedBox(width: 5),
                              Text('Selecionado'),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  34,
                                  41,
                                  45,
                                ),
                                child: Icon(
                                  Icons.person_off_outlined,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('Ocupado'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      homeModel.homeModel.quantidadeDeEscolhidos.isEmpty
                          ? Colors.white
                          : Colors.amber,
                ),
                onPressed: () {
                  if (homeModel.homeModel.quantidadeDeEscolhidos.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        content: Text(
                          'Selecione pelo menos uma cadeira!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      for (
                        int i = 0;
                        i < homeModel.homeModel.escolhidos.length;
                        i++
                      ) {
                        if (homeModel.homeModel.escolhidos[i]) {
                          ocupados.add(i);
                        }
                      }
                      homeModel.homeModel.escolhidos.fillRange(
                        0,
                        homeModel.homeModel.escolhidos.length,
                        false,
                      );
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ConfirmarCompraView()),
                    );
                  }
                },
                child: Text(
                  homeModel.homeModel.quantidadeDeEscolhidos.isEmpty
                      ? 'Selecione uma cadeira'
                      : "Confirmar a compra de ${homeModel.homeModel.quantidadeDeEscolhidos.length} ${homeModel.homeModel.quantidadeDeEscolhidos.length != 1 ? 'Ingressos' : 'Ingresso'}",
                  style: TextStyle(
                    color:
                        homeModel.homeModel.quantidadeDeEscolhidos.isEmpty
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
