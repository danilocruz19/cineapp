import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class paint_teste extends StatefulWidget {
  const paint_teste({super.key});

  @override
  State<paint_teste> createState() => paint_Testettate();
}

class paint_Testettate extends State<paint_teste> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 4,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Faça a sua assinatura'),
          SizedBox(height: 20),
          Signature(
            controller: _controller,
            height: 200,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
