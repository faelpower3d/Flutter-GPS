import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import '../nossowidget/widget_input.dart';
import '../nossowidget/widget_text_custom.dart';
import '../nossowidget/widget_button_custom.dart';
import 'package:gps/models/mensagens.dart';

class MensagensFirestore extends StatefulWidget {
  String? lat;
  String? long;
  double? latitude;
  double? longitude;

  MensagensFirestore(this.lat, this.long);

  @override
  _MensagensFirestoreState createState() => _MensagensFirestoreState();
}

class _MensagensFirestoreState extends State<MensagensFirestore> {
  final _lat = TextEditingController();
  final _long = TextEditingController();
  List _resultsList = [];

  Future<void> inicializarFirebase() async {
    await Firebase.initializeApp();
    print("Conectado ao Firebase");
  }

  @override
  void initState() {
    super.initState();
    // Carregar a posição atual quando o widget for inicializado
    posicaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    inicializarFirebase();
    _lat.text = widget.lat ?? ""; // Usar o operador ?? para lidar com valor nulo
    _long.text = widget.long ?? ""; // Usar o operador ?? para lidar com valor nulo
    return Scaffold(
      appBar: AppBar(
        title: Text("Mensagens"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.all(9),
      children: [
        Text(widget.latitude != null
            ? 'Latitude: ${widget.latitude}'
            : 'Latitude: '),
        Text(widget.longitude != null
            ? 'Longitude: ${widget.longitude}'
            : 'Longitude: '),
        TextosCustom(" ", 12, Colors.black),
        ContainerInsere(_lat, "", "Digite a mensagem:"),
        ContainerInsere(_long, "", "Digite a mensagem:"),
        BotoesCustom("Enviar", onPressed: () {
          _clicksend(context);
        }),
      ],
    );
  }

  ContainerInsere(TextEditingController txt, String label, String rotulo) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 3, right: 3, bottom: 0, top: 0),
      child: InputTextos(rotulo, label, controller: txt),
      alignment: AlignmentDirectional.topStart,
    );
  }

  void _clicksend(BuildContext ctx) async {
    // Obter a posição atual antes de enviar a mensagem
    await posicaoAtual();

    Mensagens ms = Mensagens();
    ms.dt = DateTime.now();
    ms.lat = widget.latitude?.toString() ?? ""; // Usar o operador ? para lidar com valor nulo
    ms.long = widget.longitude?.toString() ?? ""; // Usar o operador ? para lidar com valor nulo

    CollectionReference instanciaColecaoFirebase =
    FirebaseFirestore.instance.collection("msg");
    try {
      await instanciaColecaoFirebase
          .doc(ms.dt.toString().trim())
          .set(ms.toJson());
      print("Mensagem Adicionada");
    } catch (e) {
      print("Erro ao gravar no banco: $e");
    }
  }

  Future<void> posicaoAtual() async {
    try {
      Position p = await Geolocator.getCurrentPosition();
      setState(() {
        widget.latitude = p.latitude;
        widget.longitude = p.longitude;
      });
    } catch (e) {
      print("Erro ao obter posição: $e");
    }
  }
}
