import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telas_testes/features/home/home.dart';
import 'package:telas_testes/features/confirmar_compra/confirmar_compra_viewmodel.dart';
import 'package:telas_testes/features/home/viewmodel/home_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ConfirmarCompraViewmodel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
