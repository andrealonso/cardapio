import 'package:cardapio/widgets/item_estab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // final List<Widget> itens = [];
  @override
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
              children: <Widget>[
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: true,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: true,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: true,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: false,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: true,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: true,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: false,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: false,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: true,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: true,
                ),
                ItemWidget(
                  nome: 'Churrascaria',
                  km: '10 Km',
                  likes: 234,
                  favorito: true,
                ),
              ],
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


