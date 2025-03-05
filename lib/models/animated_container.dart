import 'package:flutter/material.dart';

class ContaianerAnimated extends StatefulWidget {
  int durationAnimated;
  bool comecarAnimacao;
  dynamic funcadoDoBotao;
  String textoDoBotao;
  ContaianerAnimated({
    required this.durationAnimated,
    required this.comecarAnimacao,
    required this.funcadoDoBotao,
    required this.textoDoBotao,
  });

  @override
  State<ContaianerAnimated> createState() => _ContaianerAnimatedState();
}

class _ContaianerAnimatedState extends State<ContaianerAnimated> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.durationAnimated),
      width: widget.comecarAnimacao ? 50 : 200,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(widget.comecarAnimacao ? 25 : 8),
      ),
      child: InkWell(
        onTap: widget.funcadoDoBotao,
        child: Center(
          child:
              widget.comecarAnimacao
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                    widget.textoDoBotao,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
        ),
      ),
    );
  }
}
