import 'package:cardapio/bemvindo_page.dart';
import 'package:cardapio/cad_opcao_page.dart';
import 'package:cardapio/caduser_page.dart';
import 'package:cardapio/telamodal.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: Bemvindo(),
    );
  }
}

