import 'package:flutter/material.dart';
class Botoes extends StatelessWidget {
  final  String texto;
  final void Function() onPressed;

  //Construtor com o texto do botao e a chamada da funcao onPressed
  Botoes(this.texto,  {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.blueAccent,
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),

      ),
      onPressed: onPressed,
    );
  }
}
