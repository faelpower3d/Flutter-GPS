import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'mensagens/messagesFirestore.dart';
import 'nossowidget/widget_button_custom.dart';
import 'nossowidget/widget_input.dart';
import 'nossowidget/widget_text_custom.dart';

class MenuFirestore extends StatefulWidget {
  double? latitude;
  double? longitude;

  @override
  _MenuFirestoreState createState() => _MenuFirestoreState();
}

class _MenuFirestoreState extends State<MenuFirestore> {
  String _user = "";
  String _friend = "";
  final _myuser = TextEditingController();
  final _myFriend = TextEditingController();
  late Timer _timer; // Timer para atualização periódica

  @override
  void initState() {
    super.initState();
    // Chame a função para obter a posição atual ao iniciar o estado
    posicaoAtual();

    // Configure o Timer para atualizar a cada 5 segundos
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      posicaoAtual();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha a opção"),
        actions: [
          Text(widget.latitude != null
              ? 'latitude => ${widget.latitude}'
              : 'Latitude : '),
          Text(widget.longitude != null
              ? 'longitude => ${widget.longitude}'
              : 'Longitude : '),
        ],
      ),
      body: _menu(context),
    );
  }

  Widget _menu(BuildContext ctx) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BotoesCustom("Conversar", onPressed: () {
            _bdFirestore(ctx, MensagensFirestore(_myuser.text.toString(), _myFriend.text.toString()));
          }),
          TextosCustom("Seu usuário:", 18, Colors.black),
          TextosCustom("Com quem você quer conversar?", 18, Colors.black),
          ContainerInsere(_myFriend, ""),

        ],
      ),
    );
  }

  Widget ContainerInsere(TextEditingController txt, String label) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 0),
      child: InputTextos("", "your user", controller: txt),
      alignment: AlignmentDirectional.topStart,
    );
  }

  void _bdFirestore(BuildContext ctx, MensagensFirestore page) {
    Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  void posicaoAtual() async {
    Position p = await Geolocator.getCurrentPosition();
    setState(() {
      widget.latitude = p.latitude;
      widget.longitude = p.longitude;
    });
  }
}
