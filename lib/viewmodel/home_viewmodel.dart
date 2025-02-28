import 'package:flutter/material.dart';
import 'package:telas_testes/model/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeModel homeModel = HomeModel.inicializar();

  void mudarEscolha(int index) {
    final cadeira = index + 1;
    homeModel.escolhidos[index] = !homeModel.escolhidos[index];

    if (homeModel.escolhidos[index]) {
      homeModel.quantidadeDeEscolhidos.add(cadeira);
    } else {
      homeModel.quantidadeDeEscolhidos.remove(cadeira);
    }
    notifyListeners();
  }

  bool temIngressosSelecionados() {
    return homeModel.quantidadeDeEscolhidos.isNotEmpty;
  }
}
