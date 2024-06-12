import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double? latitude;
  double? longitude;
  String? endereco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          latitude != null ? Text('latitude => $latitude'): Text('Latitude : '),
          longitude != null ? Text('longitude => $longitude'): Text('longitude : '),
          endereco != null ? Text('endereço => $endereco'): Text('endereço : '),

        TextButton(child: Text('pegar posição'), onPressed: (){
          posicaoAtual();
        },),
        ],
      ),
    );
  }

  posicaoAtual() async{
    Position p = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = p.latitude;
      longitude=p.longitude;
    });

  }
}
