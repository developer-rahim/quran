import 'package:api_test/quran_app/screen/sura_name.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

double fontsize = 16;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      home: HomePage(),
    );
  }
}
