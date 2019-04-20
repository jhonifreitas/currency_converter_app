import 'package:flutter/material.dart';
import 'package:currency_converter_app/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moedas',
      theme: ThemeData(
        hintColor: Colors.green,
        primaryColor: Colors.green
      ),
      home: HomePage(),
    );
  }
}
