import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import '../models/EnviaFirebase.dart';



class MensagensFirestore extends StatefulWidget {
  String? lat;
  String? long;
  double? latitude;
  double? longitude;
  String colecao;

  MensagensFirestore(this.lat, this.long, this.colecao);

  @override
  _MensagensFirestoreState createState() => _MensagensFirestoreState();
}

class _MensagensFirestoreState extends State<MensagensFirestore> {
  late Timer _timer;
  bool _ativo = false;

  Future<void> inicializarFirebase() async {
    await Firebase.initializeApp();
    print("Conectado ao Firebase");
  }

  @override
  void initState() {
    super.initState();
    inicializarFirebase();

    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
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
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20.0),
        children: [
          ElevatedButton(
            onPressed: () {
              if (_timer.isActive) {
                _timer.cancel();
                _ativo = true;
                print("Localização desligada");
              } else {
                _timer = Timer.periodic(Duration(seconds: 6), (timer) {
                  posicaoAtual();
                });
                _ativo = false;
                print("Localização ligada");
              }
              setState(() {}); // Para atualizar a interface após mudança no timer
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _ativo ? Colors.green : Colors.red,
            ),
            child: Text(_timer.isActive ? 'Desligar Localização' : '🚩 Ligar localização'),
          ),
        ],
      ),
    );
  }

  ContainerInsere(TextEditingController txt, String label, String rotulo) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 3, right: 3, bottom: 0, top: 0),
      alignment: AlignmentDirectional.topStart,
    );
  }

  Future<void> posicaoAtual() async {
    try {
      Position p = await Geolocator.getCurrentPosition();
      setState(() {
        widget.latitude = p.latitude;
        widget.longitude = p.longitude;
      });
      DadosLocal dl = DadosLocal();
      dl.dt = DateTime.now();
      dl.lat = widget.latitude?.toString() ?? "";
      dl.long = widget.longitude?.toString() ?? "";

      CollectionReference instanciaColecaoFirebase =
      FirebaseFirestore.instance.collection(widget.colecao);
      try {
        await instanciaColecaoFirebase
            .doc(dl.dt.toString().trim())
            .set(dl.toJson());
        print("LOCAL ATUALIZADO");
      } catch (e) {
        print("Erro ao gravar no banco: $e");
      }
    } catch (e) {
      print("Erro ao obter posição: $e");
    }
  }
}

