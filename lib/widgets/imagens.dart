import 'package:flutter/material.dart';
class SuaImagem extends StatefulWidget {
  final String caminhoArquivo;
  const SuaImagem({Key? key, required this.caminhoArquivo}) : super(key: key);

  @override
  State<SuaImagem> createState() => _SuaImagemState();
}

class _SuaImagemState extends State<SuaImagem> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
        widget.caminhoArquivo,
        fit: BoxFit.cover,
        scale: 50,
    );
  }
}
