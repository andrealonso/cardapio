import 'package:cardapio/models/perfil_user_modal.dart';
import 'package:flutter/material.dart';

class MenuPerfil extends StatelessWidget {
  final PerfilUsuarioModel perfilCliente;

  const MenuPerfil({Key key, this.perfilCliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Image.network(perfilCliente.img),
            accountName: Text(perfilCliente.nome),
            accountEmail: Text(perfilCliente.usuario),
          ),
          ListTile(title: Text('Alterar perfil'), trailing: Icon(Icons.navigate_next),onTap: (){},),
          ListTile(title: Text('Meus Favoritos'), trailing: Icon(Icons.navigate_next),onTap: (){},),
          ListTile(title: Text('Meus Amigos'), trailing: Icon(Icons.navigate_next),onTap: (){},),
        ],
      ),
    );
  }
}
