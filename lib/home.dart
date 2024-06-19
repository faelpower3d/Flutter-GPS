import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'localizacao/localizacaoFirestore.dart';
import 'widgets/widgetsButton.dart';
import 'widgets/widgetsInput.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pwd = TextEditingController();
  String _authorized = "";
  String _msg = "";
  TextEditingController _myuser = TextEditingController();
  TextEditingController _myFriend = TextEditingController();
  late FirebaseAuth _auth;
  Color _colors = Colors.red;
  TextEditingController _collectionNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.fromLTRB(20,0,20,300),
      shrinkWrap: true,
      children: [
        InputTextos("Login", "Email", controller: _email),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: "Senha",
            hintText: "Digite sua senha",
          ),
          controller: _pwd,
          obscureText: true,
        ),
        SizedBox(height: 16),
        InputTextos("Motorista", "Name", controller: _collectionNameController),
        SizedBox(height: 60),
        Botoes("Authenticate", onPressed: () {
          _authenticate(context);
        }),
        SizedBox(height: 16),
        if (_msg.isNotEmpty)
          Text(
            _msg,
            style: TextStyle(color: Colors.red),
          ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_authorized, style: TextStyle(fontSize: 18, color: _colors)),
          ],
        ),
      ],
    );
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  Future<void> _authenticate(BuildContext ctx) async {
    String collectionName = _formatCollectionName(_collectionNameController.text.trim());
    if (collectionName.isEmpty) {
      setState(() {
        _msg = "Digite o nome do motorista";
      });
      return;
    }

    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: _email.text.toString(),
        password: _pwd.text.toString(),
      );
      _bdFirestore(ctx, collectionName);
      setState(() {
        _authorized = "conectado";
        _colors = Colors.blueAccent;
      });
    } catch (e) {
      setState(() {
        _authorized = "credencial incorreto";
      });
    }
  }

  void _bdFirestore(BuildContext ctx, String collectionName) {
    Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext context) {
      return MensagensFirestore(_myuser.text.toString(), _myFriend.text.toString(), collectionName);
    }));
  }

  String _formatCollectionName(String name) {
    if (name.isEmpty) return "";
    return name.substring(0, 1).toUpperCase() + name.substring(1).toLowerCase();
  }
}
