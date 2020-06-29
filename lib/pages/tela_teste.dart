import 'package:cardapio/main.dart';
import 'package:cardapio/pages/bemvindo_page.dart';
import 'package:cardapio/pages/cad_estab_page1.dart';
import 'package:cardapio/pages/cad_opcao_page.dart';
import 'package:cardapio/pages/cad_produto_page.dart';
import 'package:cardapio/pages/cad_user_page.dart';
import 'package:cardapio/pages/cardapio_page.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/pages/inicial_page.dart';
import 'package:cardapio/pages/login_page.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaTeste extends StatefulWidget {
  @override
  _TelaTesteState createState() => _TelaTesteState();
}

class _TelaTesteState extends State<TelaTeste> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  void snack(String texto) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text(texto)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                BotaoWidget(
                  nome: 'Bem vindo',
                  clicar: () {
                    gotTo(Bemvindo());
                  },
                ),
                BotaoWidget(
                  nome: 'login',
                  clicar: () {
                    gotTo(LoginPage());
                  },
                ),
                BotaoWidget(
                  nome: 'Inicio',
                  clicar: () {
                    gotTo(Inicial());
                  },
                ),
                BotaoWidget(
                  nome: 'HOME',
                  clicar: () {
                    gotTo(HomePage());
                  },
                ),
                BotaoWidget(
                  nome: 'Cardapio',
                  clicar: () {
                    gotTo(CardapioPage());
                  },
                ),
                BotaoWidget(
                  nome: 'Cad User',
                  clicar: () {
                    gotTo(CadUserPage());
                  },
                ),
                BotaoWidget(
                  nome: 'Cad Estab',
                  clicar: () {
                    gotTo(CadEstabStep1());
                  },
                ),
                BotaoWidget(
                  nome: 'Cad Prod',
                  clicar: () {
                    gotTo(CadProdutoForm());
                  },
                ),
                BotaoWidget(
                  nome: 'Cad Opção',
                  clicar: () {
                    gotTo(CadOpcaoPage());
                  },
                ),
                BotaoWidget(
                  nome: 'LogOff',
                  clicar: _sair,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sair() async {
    try {
      await _auth.signOut();
      snack('Usuario deslogado!');
    } catch (e) {
      print(e);
    }
  }

  void gotTo(Widget tela) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => tela));
  }
}
