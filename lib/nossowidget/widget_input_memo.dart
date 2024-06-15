import 'package:flutter/material.dart';
class InputTextosMemo extends StatelessWidget {
  String rotulo;
  String label;
  TextEditingController controller;

  InputTextosMemo(this.rotulo, this.label, {required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 2,
      maxLength: 120,
      controller: controller,
      style: TextStyle(
          color: Colors.black,
        backgroundColor: Colors.white,
        decorationColor: Colors.redAccent,
      ),
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: label,
        focusColor: Colors.redAccent,
        fillColor: Colors.redAccent
      ) ,
    );
  }
}
