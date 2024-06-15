import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gps/models/mensagens.dart';
import '../nossowidget/widget_input.dart';
import '../nossowidget/widget_text_custom.dart';
import '../nossowidget/widget_button_custom.dart';

class MensagensFirestore extends StatefulWidget {
String user;
String friend;
MensagensFirestore(this.user, this.friend);

  @override
  _MensagensFirestoreState createState() => _MensagensFirestoreState();
}

class _MensagensFirestoreState extends State<MensagensFirestore> {
  final _friend= TextEditingController();
  final _user = TextEditingController();
  final _msg = TextEditingController();
  final _qtdmsg = TextEditingController();
   List _resultsList = [];

  Future <void> inicializarFirebase() async {
    await Firebase.initializeApp();
    Firebase.initializeApp().whenComplete(() => print("conectado Firebase"));
    Firebase.initializeApp().whenComplete(() => print("conectado Firebase"));
    Firebase.initializeApp().whenComplete(() => print("conectado Firebase"));
    Firebase.initializeApp().whenComplete(() => print("conectado Firebase"));
    Firebase.initializeApp().whenComplete(() => print("conectado Firebase"));
  }

  @override
  Widget build(BuildContext context) {
    inicializarFirebase();
    _user.text=widget.user.toString();
    _friend.text=widget.friend.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Mensagenss"),

      ),
      body: _body(),
    );
  }
  _body(){
    return ListView(
    padding: EdgeInsets.all(9),
    children: [
      TextosCustom("Conversas com seu amigo: "+ _friend.text , 16, Colors.redAccent),
      TextosCustom(" ", 12, Colors.black),
      ContainerInsere(_msg, "","Digite a mensagem:"),
      BotoesCustom("Enviar", onPressed:() {
        _clicksend(context);
          }
        ),
      BotoesCustom("Receber", onPressed: _buscaRegistro)
    ],
    );


  }



  ContainerInsere(TextEditingController txt, String label, String rotulo)
  {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 3, right: 3, bottom: 0, top: 0),
      child: InputTextos(rotulo, label,controller: txt,),
      alignment: AlignmentDirectional.topStart,
    );
  }


  void _clicksend(BuildContext ctx) {
    Mensagens ms = new Mensagens();
    ms.friend=_friend.text.toString().trim();
    ms.user=_user.text.toString().trim();
    ms.msg=_msg.text.toString().trim();
    ms.dt=DateTime.now();
    
    CollectionReference instaciaColecaoFirebase = FirebaseFirestore.instance.collection("msg");
    Future<void> addMsg(){
      return instaciaColecaoFirebase
          .doc(ms.dt.toString().trim())
          .set(ms.toJson())
          .then((value)=> print("Mensagem Adicionadaaaaaaaaa"))
          .catchError((onError) => print("Erro ao gravar no banco $onError"));

    }
    addMsg();
  }





  void _buscaRegistro() {
  }
}
