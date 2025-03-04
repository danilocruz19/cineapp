import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telas_testes/features/tela_do_cartao/cartao_view.dart';
import 'package:telas_testes/features/pagamento_concluido/pagamento_concluido.dart';
import 'package:telas_testes/features/confirmar_compra/viewmodel/confirmar_compra_viewmodel.dart';
import 'package:telas_testes/features/home/viewmodel/home_viewmodel.dart';
import 'package:telas_testes/features/tela_do_pix/tela_pix_view.dart';
import 'package:telas_testes/models/animated_container.dart';

class ConfirmarCompraView extends StatefulWidget {
  const ConfirmarCompraView({super.key});

  @override
  State<ConfirmarCompraView> createState() => _ConfirmarCompraViewState();
}

class _ConfirmarCompraViewState extends State<ConfirmarCompraView> {
  int? metodoDePagamentoSelecionadoIndex;
  bool _carregarPagamento = false;
  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final cadeirasSelecionadas = homeViewModel.homeModel.quantidadeDeEscolhidos;
    cadeirasSelecionadas.sort();
    final confirmacaoDeCompra = context.watch<ConfirmarCompraViewmodel>();

    void animatedButton() {
      setState(() {
        if (metodoDePagamentoSelecionadoIndex == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Selecione um método de pagamento',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          setState(() {
            _carregarPagamento = true;
          });

          Future.delayed(Duration(seconds: 3), () {
            if (metodoDePagamentoSelecionadoIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaPixView()),
              );
            } else if (metodoDePagamentoSelecionadoIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartaoView()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PagamentoConcluido()),
              );
            }
            for (var cadeira
                in homeViewModel.homeModel.quantidadeDeEscolhidos) {
              homeViewModel.marcarOcupado(cadeira - 1);
            }
            homeViewModel.homeModel.quantidadeDeEscolhidos.clear();
          });
        }
      });
    }

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
                    SizedBox(
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
                      trailing: Text(
                        confirmacaoDeCompra.numeroFormatado(
                          confirmacaoDeCompra.confirmarModel.precoDoIngresso,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Valor total'),
                      trailing: Text(
                        confirmacaoDeCompra.numeroFormatado(
                          confirmacaoDeCompra.confirmarModel.precoDoIngresso *
                              cadeirasSelecionadas.length,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text('Método de pagamento'),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final pagamentos =
                              confirmacaoDeCompra
                                  .confirmarModel
                                  .metodoDePagamento[index];
                          return ListTile(
                            title: Text(pagamentos),
                            trailing: Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.amber,
                              value: metodoDePagamentoSelecionadoIndex == index,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  metodoDePagamentoSelecionadoIndex =
                                      newValue! ? index : null;
                                });
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount:
                            confirmacaoDeCompra
                                .confirmarModel
                                .metodoDePagamento
                                .length,
                      ),
                    ),
                    Center(
                      child: ContaianerAnimated(
                        durationAnimated: 400,
                        comecarAnimacao: _carregarPagamento,
                        funcadoDoBotao: animatedButton,
                        textoDoBotao: 'Confirmar pagamento',
                      ),
                    ),
                  ],
                ),
              )
              : Center(child: Text('Nenhuma cadeira selecionada')),
    );
  }
}
