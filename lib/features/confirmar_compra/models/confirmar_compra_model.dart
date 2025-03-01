class ConfirmarCompraModel {
  double precoDoIngresso;
  double valorTotal;
  List<String> metodoDePagamento;

  ConfirmarCompraModel({
    this.precoDoIngresso = 0,
    this.valorTotal = 0,
    this.metodoDePagamento = const [],
  });
}
