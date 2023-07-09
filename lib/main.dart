import 'package:api_test/online_quran_app/screens/online_sura_page.dart';
import 'package:flutter/material.dart';

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
      home: OnlineSuraPage(),
    );
  }
}
