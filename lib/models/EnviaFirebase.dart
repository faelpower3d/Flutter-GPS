import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DadosLocal {
  String lat = "";
  String long = "";
  DateTime dt = DateTime.now();

  DadosLocal();
  Map<String, dynamic> toJson() =>{
        'cordenada': 'https://www.google.com/search?q=$lat%2C$long',
        'dt': dt
      };

}


