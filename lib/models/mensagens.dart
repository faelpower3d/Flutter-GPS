import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Mensagens {
  String lat = "";
  String long = "";

  DateTime dt = DateTime.now();

  Mensagens();

  Map<String, dynamic> toJson() =>{
        'cordenada': '$lat,$long',
        'dt': dt
      };

}


