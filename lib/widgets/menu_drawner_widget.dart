import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/pages/bemvindo_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MenuDrawerWidget extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final userAtual = GetIt.I<UserController>().usuarioAtual;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(child: Text(userAtual.usuario)),
        Spacer(),
        FlatButton.icon(
            onPressed: () {
              _sair(context);
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Sair'))
      ]),
    );
  }

  _sair(contexto) async {
    await _auth.signOut();
    Navigator.of(contexto)
        .pushReplacement(MaterialPageRoute(builder: (context) => Bemvindo()));
  }
}
