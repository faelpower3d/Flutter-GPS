import 'package:flutter/material.dart';


class MessageList extends StatefulWidget {

  String user;
  String friend;
  MessageList(this.user, this.friend);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List _resultsList = [];




  @override
  Widget build(BuildContext context) {
    _buscaRegistro();
    return Scaffold(
    appBar: AppBar(
    title: Text("Lista conversas"),
    actions: [
      IconButton(
        onPressed: _buscaRegistro,
        icon: Icon(Icons.search),
      )
    ],
    ),
    body: _lista(),
    );
  }




  _lista() {

}




  void _buscaRegistro() {
  }
}




