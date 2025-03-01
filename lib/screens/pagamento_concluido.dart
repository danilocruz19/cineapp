import 'package:flutter/material.dart';
import 'package:telas_testes/screens/home.dart';

class PagamentoConcluido extends StatefulWidget {
  const PagamentoConcluido({super.key});

  @override
  State<PagamentoConcluido> createState() => _PagamentoConcluidoState();
}

class _PagamentoConcluidoState extends State<PagamentoConcluido> {
  bool _showCheck = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _showCheck = true;
      });
    });
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _showCheck ? 1.0 : 0.0,
              duration: Duration(seconds: 3),
              child: Icon(Icons.check, size: 100, color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            AnimatedOpacity(
              opacity: _showCheck ? 1.0 : 0.0,
              duration: Duration(seconds: 3),
              child: Text(
                'Pagamento Aprovado!',
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
