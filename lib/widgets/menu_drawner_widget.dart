import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/pages/cad_user_page.dart';
import 'package:cardapio/pages/inicial_page.dart';
import 'package:cardapio/util/constantes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MenuDrawerWidget extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final userAtual = GetIt.I<UserController>().usuarioAtual;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: userAtual.img != null
                        ? NetworkImage(userAtual.img)
                        : NetworkImage(imageAvatarPadrao),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(userAtual.usuario),
              ],
            ),
          ),
          ListTile(
            title: Text('Alterar perfil'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              _goPush(
                  context,
                  CadUserPage(
                    usuario: userAtual,
                    editar: true,
                  ));
            },
          ),
          ListTile(
            title: Text('Cadastro de estabelecimento'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              _goPush(
                  context,
                  CadUserPage(
                    usuario: userAtual,
                    editar: true,
                  ));
            },
          ),
          Spacer(),
          FlatButton.icon(
              onPressed: () {
                _sair(context);
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('Sair'))
        ],
      ),
    );
  }

  _sair(context) async {
    await _auth.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Inicial()));
  }

  _goPush(context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  _goPushReplace(context, Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
}
