import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class InputTextos extends StatelessWidget {
  String rotulo; //Podera atribuir um rótulo
  String label; //Podera atribuir um "hint"
  TextEditingController controller;
  //Para pegar o texto digitado

  InputTextos(this.rotulo, this.label, {required this.controller});
  //Construtor

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller:  controller,
      style: TextStyle (
          color: Colors.black,
          backgroundColor: Colors.white
      ),
      decoration: InputDecoration(
          labelText: rotulo,
          hintText: label
      ),
    );

  }


}
