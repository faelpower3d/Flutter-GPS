import 'package:flutter/material.dart';
class InputTextos extends StatelessWidget {
  String rotulo;
  String label;
  TextEditingController controller;

  InputTextos(this.rotulo, this.label, {required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      style: TextStyle(
          color: Colors.black,
          backgroundColor: Colors.white,
          fontSize: 20
      ),
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: label,
        focusColor: Colors.red,
        hoverColor: Colors.redAccent,
        labelStyle: TextStyle(
          color: Colors.redAccent,
          decorationColor: Colors.redAccent,
          fontSize: 22
        )
      )
    );
  }
}
