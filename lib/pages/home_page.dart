import 'package:cardapio/widgets/item_estab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  // final List<Widget> itens = [];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titulo = '';
  var estabelecimentos = [];

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((instance) {
      setState(() {
        titulo = instance.getString('nome');
      });
    });

    Dio().get('http://www.mocky.io/v2/5eb1b10f320000769428f8f8').then((resp) {
      setState(() {
        estabelecimentos = resp.data;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estabelecimentos'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(children: [
              Container(
                height: 50,
                width: 300,
                padding: EdgeInsets.only(left: 15),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Pesquisar estabelecimentos'),
                ),
              ),
              IconButton(icon: Icon(Icons.search), onPressed: null)
            ]),
          ),
          Expanded(
            child: ListView(
              children: estabelecimentos.map((estab) {
                return ItemWidget(img: estab['imagem'],nome: estab['nome'], km: estab['distancia'], likes: estab['likes'], favorito: estab['favorito']);
              }).toList(),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Filtrar');
        },
        child: Icon(
          Icons.filter_list,
          size: 34,
        ),
        elevation: 20,
      ),
    );
  }
}
