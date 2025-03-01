import 'package:flutter/material.dart';
import 'package:telas_testes/features/home/model/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeModel homeModel = HomeModel.inicializar();
  List<int> ocupados = [];
   bool assentosVisivel = false;

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

  void marcarOcupado(int index) {
    if (!ocupados.contains(index)) {
      ocupados.add(index);
      notifyListeners();
    }
  }

  List<int> getAssentosOcupados() {
    return ocupados;
  }

  void limparSelecao() {
    homeModel.quantidadeDeEscolhidos.clear();
    notifyListeners();
  }
}
