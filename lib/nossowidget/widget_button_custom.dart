import 'package:flutter/material.dart';
class BotoesCustom extends StatelessWidget {
  final String texto;
  final void Function() onPressed;
  BotoesCustom (this.texto, {required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          /*onPrimary: Colors.grey[300],
          primary: Colors.redAccent,*/
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
          )
        ),
        child: Text(texto),
        onPressed: onPressed);
  }
}
