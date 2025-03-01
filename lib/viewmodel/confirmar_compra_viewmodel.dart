import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telas_testes/model/confirmar_compra_model.dart';

class ConfirmarCompraViewmodel extends ChangeNotifier {
  ConfirmarCompraModel confirmarModel = ConfirmarCompraModel(
    precoDoIngresso: 15,
    metodoDePagamento: ['Dinheiro', 'Pix', 'Débito / Crédito'],
  );

  String numeroFormatado(double numero) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(numero);
  }

  List<String> metodoDePagamento = [
    'Dinheiro',
    'Pix',
    'Débito / Crédito'
  ];
}
