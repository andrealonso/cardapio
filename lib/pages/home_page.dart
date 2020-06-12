import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/perfil_user_modal.dart';
import 'package:cardapio/pages/bemvindo_page.dart';
import 'package:cardapio/services/perfil_usuario_service.dart';
import 'package:cardapio/widgets/item_estab.dart';
import 'package:cardapio/widgets/menu_perfil_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  // final List<Widget> itens = [];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titulo = '';
  var estabelecimentos = [];
  final _auth = FirebaseAuth.instance;
  final _perfilserve = PerfilUsuarioService();
  PerfilUsuarioModel perfilAtual;

  @override
  void initState() {
    super.initState();
    _perfilserve.getPerfil().then((resp) {
      setState(() {
        perfilAtual = resp;
      });
    });

    // SharedPreferences.getInstance().then((instance) {
    //   setState(() {
    //     titulo = instance.getString('nome');
    //   });
    // });

    Dio().get('http://www.mocky.io/v2/5eb1b10f320000769428f8f8').then((resp) {
      setState(() {
        estabelecimentos = resp.data;
      });
    });
  }

  Widget build(BuildContext context) {
    final userAtual = GetIt.I<UserController>().usuarioAtual;
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text('Bem vindo: ${userAtual?.nome}');
        }),
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
                return ItemWidget(
                    img: estab['imagem'],
                    nome: estab['nome'],
                    km: estab['distancia'],
                    likes: estab['likes'],
                    favorito: estab['favorito']);
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

  _sair() async {
    await _auth.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Bemvindo()));
  }
}
