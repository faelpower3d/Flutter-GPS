import 'package:flutter/material.dart';

class TextosCustom extends StatelessWidget {
  String seuTexto;
  double fontSize;
  Color fontColor;
  TextosCustom(this.seuTexto, this.fontSize, this.fontColor);
  @override
  Widget build(BuildContext context) {
    return Text(

      seuTexto,
      maxLines: 4,
      softWrap: true,
      style: TextStyle(
          color: fontColor,
          //backgroundColor:Colors.blue,
          fontSize: fontSize,
      ),
    );
  }

}
