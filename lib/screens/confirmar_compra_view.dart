import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telas_testes/viewmodel/confirmar_compra_viewmodel.dart';
import 'package:telas_testes/viewmodel/home_viewmodel.dart';

class ConfirmarCompraView extends StatefulWidget {
  const ConfirmarCompraView({super.key});

  @override
  State<ConfirmarCompraView> createState() => _ConfirmarCompraViewState();
}

class _ConfirmarCompraViewState extends State<ConfirmarCompraView> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final cadeirasSelecionadas = homeViewModel.homeModel.quantidadeDeEscolhidos;
    cadeirasSelecionadas.sort();
    final confirmacaoDeCompra = context.watch<ConfirmarCompraViewmodel>();
    return Scaffold(
      appBar: AppBar(title: Text('Confirmação de compra')),
      body:
          cadeirasSelecionadas.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cadeiras selecionadas',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cadeirasSelecionadas.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Icon(Icons.chair, size: 50),
                              Text(
                                "${cadeirasSelecionadas[index]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Quantidade de ingressos'),
                      trailing: Text("${cadeirasSelecionadas.length}"),
                    ),
                    ListTile(
                      title: Text('Valor de cada ingresso'),
                      trailing: Text(confirmacaoDeCompra.numeroFormatado(confirmacaoDeCompra.confirmarModel.precoDoIngresso)),
                    ),
                    ListTile(
                      title: Text('Valor total'),
                      trailing: Text(confirmacaoDeCompra.numeroFormatado(confirmacaoDeCompra.confirmarModel.precoDoIngresso * cadeirasSelecionadas.length)),
                    ),
                  ],
                ),
              )
              : Center(child: Text('Nenhuma cadeira selecionada')),
    );
  }
}
