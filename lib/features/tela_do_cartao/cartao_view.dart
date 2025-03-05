import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:telas_testes/features/pagamento_concluido/pagamento_concluido.dart';
import 'package:telas_testes/models/animated_container.dart';

class CartaoView extends StatefulWidget {
  const CartaoView({super.key});

  @override
  State<CartaoView> createState() => _CartaoViewState();
}

bool _animacaoText = false;

class _CartaoViewState extends State<CartaoView> {
  final TextEditingController _controllerCartao = TextEditingController();
  final TextEditingController _controllerData = TextEditingController();
  final TextEditingController _controllerCvv = TextEditingController();
  bool _carregarAnimacao = false;

  void carregarAnimacao() {
    if (_key.currentState!.validate()) {
      setState(() {
        _carregarAnimacao = true;
      });
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PagamentoConcluido()),
          (_) => false,
        );
      });
    }
  }

  String cardNumber = '';
  String validDate = '';
  String cvv = '';

  @override
  void initState() {
    super.initState();

    _controllerCartao.addListener(() {
      setState(() {
        cardNumber = _controllerCartao.text;
      });
    });
    _controllerData.addListener(() {
      setState(() {
        validDate = _controllerData.text;
      });
    });
    _controllerCvv.addListener(() {
      setState(() {
        cvv = _controllerCvv.text;
      });
    });

    _controllerCartao.addListener(_verificarTamanho);
  }

  @override
  void dispose() {
    _controllerCartao.removeListener(_verificarTamanho);
    _controllerCartao.dispose();
    super.dispose();
  }

  void _verificarTamanho() {
    setState(() {
      _animacaoText = _controllerCartao.text.length == 16;
    });
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CreditCardWidget(
                    cardBgColor: const Color.fromARGB(255, 0, 0, 0),
                    enableFloatingCard: true,
                    cardNumber: cardNumber,
                    obscureCardNumber: false,
                    expiryDate: validDate,
                    cardHolderName: 'Danilo Cruz',
                    cvvCode: cvv,
                    obscureCardCvv: false,
                    showBackView: false,
                    onCreditCardWidgetChange: (
                      CreditCardBrand creditCardBrand,
                    ) {
                      [
                        CustomCardTypeIcon(
                          cardType: CardType.mastercard,
                          cardImage: Image.asset(
                            'mastercard.png',
                            width: 48,
                            height: 48,
                          ),
                        ),
                      ];
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O campo de cartão não pode estar vazio';
                      }
                      return null;
                    },
                    controller: _controllerCartao,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 109, 109, 109),
                        ),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Número do cartão',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                  ),
                  SizedBox(height: 10),
                  if (_animacaoText)
                   Column(
                    children: [
                       TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: _controllerData,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 109, 109, 109),
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Data de validade',
                      ),
                    ),
                     SizedBox(height: 10),
                     TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _controllerCvv,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 109, 109, 109),
                        ),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                    ),
                  ),
                    ],
                   ),
                  SizedBox(height: 20),
                  ContaianerAnimated(
                    durationAnimated: 400,
                    comecarAnimacao: _carregarAnimacao,
                    funcadoDoBotao: carregarAnimacao,
                    textoDoBotao: 'Confirmar Pagamento',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
