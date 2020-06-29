import 'package:cardapio/controllers/estab_controller.dart';
import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/pages/tela_teste.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// import 'package:cardapio/pages/produto_view_page.dart';
GetIt getIt = GetIt.instance;
void main() {
  getIt.registerSingleton<UserController>(UserController(), signalsReady: true);

  getIt.registerSingleton<EstabController>(EstabController(),
      signalsReady: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaTeste(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dbEstab = Firestore.instance;
  List<Produto> produtos = [];

  void getDoc() async {
    var snapshot = await dbEstab
        .collection("estabelecimentos")
        .document('AVya9zPvGtI0Jspv5aj4')
        .collection('prod')
        .getDocuments();
    produtos.clear();
    snapshot.documents.forEach((f) => produtos.add(Produto.fromJson(f.data)));
    print(produtos[0].nome);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Teste Firestore'),
          SizedBox(
            height: 100,
          ),
          RaisedButton(
              child: Text("Testar"),
              onPressed: () {
                // dbEstab.collection('estab').document().setData({'titulo':'2222', 'autor':'2222'});
                // dbEstab
                //     .collection("estab")
                //     .document('WdsUnWFGeo6Q5GS2ntSc')
                //     .get()
                //     .then();
                getDoc();
              }),
          Column(
            children: produtos.map((produto) {
              return Card(
                child: ListTile(
                  title: Text(produto.nome),
                  trailing: Text(produto.preco.toString()),
                ),
              );
            }).toList(),
          )
        ],
      )),
    );
  }
}

class Produto {
  String nome;
  double preco;

  Produto.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    preco = double.parse(json['preco'].toString());
  }
}
