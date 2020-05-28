import 'package:cardapio/pages/bemvindo_page.dart';
import 'package:cardapio/pages/cad_opcao_page.dart';
import 'package:cardapio/pages/caduser_page.dart';
import 'package:cardapio/pages/produto_view_page.dart';
import 'package:cardapio/telamodal.dart';
import 'package:flutter/material.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/pages/login_page.dart';
// import 'package:cardapio/pages/produto_view_page.dart';

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
      home: ProdutoViewPage(),
    );
  }
}


// Dados para Mocky API

// [
//   {
//   "imagem": "https://cdn.neemo.com.br/uploads/settings_webdelivery/logo/562/D08A2322-FDFB-48F4-805F-921446E59810__1_.jpeg",
//   "nome":"House 82",
//   "distancia": "2 Km",
//   "likes": 542,
//   "favorito": true
//   },
//   {
//   "imagem": "https://static.baratocoletivo.com.br/2019/1106/oferta_15730732931441_destaque.jpg",
//   "nome":"Pizzaria Fornalha",
//   "distancia": "3 Km",
//   "likes": 342,
//   "favorito": false
//   },
//   {
//   "imagem": "http://www.visitepetropolis.com/upload/explorar/palho%C3%A7a-(1).jpg",
//   "nome":"Churrascaria Rei do Gado",
//   "distancia": "2,3 Km",
//   "likes": 200,
//   "favorito": true
//   }

// ]
