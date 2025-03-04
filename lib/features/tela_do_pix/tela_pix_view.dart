import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:telas_testes/features/home/home.dart';
import 'package:telas_testes/features/pagamento_concluido/pagamento_concluido.dart';

class TelaPixView extends StatefulWidget {
  const TelaPixView({super.key});

  @override
  State<TelaPixView> createState() => _TelaPixViewState();
}

class _TelaPixViewState extends State<TelaPixView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: PixQRCode()));
  }
}

class PixQRCode extends StatefulWidget {
  @override
  State<PixQRCode> createState() => _PixQRCodeState();
}

class _PixQRCodeState extends State<PixQRCode> {
  bool _carregarAnimacao = false;
  @override
  Widget build(BuildContext context) {
    // Aqui você montaria o seu código Pix
    String pixCode = "0530bb1b-12d5-443a-824d-df6656e37f5c";

    void animatedButton() {
      setState(() {
        _carregarAnimacao = true;
      });
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PagamentoConcluido()),
          (route) => false,
        );
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QrImageView(
          data: pixCode, // A string do Pix é passada aqui
          version: QrVersions.auto,
          size: 300.0,
          foregroundColor: Colors.white,
        ),
        SelectableText(
          pixCode,
          onTap: () {
            Clipboard.setData(ClipboardData(text: pixCode));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Código Pix copiado para a área de transferencia',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
        SizedBox(height: 30),
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          width: _carregarAnimacao ? 50 : 200,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(_carregarAnimacao ? 25 : 8),
          ),
          child: InkWell(
            onTap: animatedButton,
            child: Center(
              child:
                  _carregarAnimacao
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                        'Confirmar pagamento',
                        style: TextStyle(color: Colors.white),
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
