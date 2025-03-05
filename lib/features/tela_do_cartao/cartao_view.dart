import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:telas_testes/features/pagamento_concluido/pagamento_concluido.dart';
import 'package:telas_testes/features/tela_do_pix/tela_pix_view.dart';
import 'package:telas_testes/models/animated_container.dart';

class CartaoView extends StatefulWidget {
  const CartaoView({super.key});

  @override
  State<CartaoView> createState() => _CartaoViewState();
}

class _CartaoViewState extends State<CartaoView> {
  TextEditingController _controllerCartao = TextEditingController();
  TextEditingController _controllerData = TextEditingController();
  TextEditingController _controllerCvv = TextEditingController();
  bool _carregarAnimacao = false;

  void carregarAnimacao() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Form(
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
                      CustomCardTypeIcon:
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
                  ),
                  SizedBox(height: 10),
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
                      labelText: 'Data de válidade',
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
