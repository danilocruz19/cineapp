class HomeModel {
  List<bool> escolhidos;
  List<int> quantidadeDeEscolhidos;
  List<int> itens;

  HomeModel({
    required this.escolhidos,
    required this.quantidadeDeEscolhidos,
    required this.itens,
  });

  factory HomeModel.inicializar() {
    return HomeModel(
      escolhidos: List.generate(50, (index) => false),
      quantidadeDeEscolhidos: [],
      itens: List.generate(30, (index) => index + 1),
    );
  }
}
