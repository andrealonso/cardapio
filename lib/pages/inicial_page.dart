import 'package:cardapio/controllers/estab_controller.dart';
import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/pages/bemvindo_page.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/services/estab_service.dart';
import 'package:cardapio/services/usuario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  final _auth = FirebaseAuth.instance;
  final _service = UsuarioService();

  @override

  Widget build(BuildContext context) {
    _navegar(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _navegar(BuildContext context) async {
    final userAtual = await _auth.currentUser();

    if (userAtual != null) {
      try {
        final usuarioAtual = await _service.getPerfil();
        print("tela inicial ${usuarioAtual.nome}");
        
        GetIt.I<UserController>().setUsuario(usuarioAtual);

        
        _navegateTo(HomePage());
      } catch (e) {
        _navegateTo(Bemvindo());
      }
    } else {
      _navegateTo(Bemvindo());
    }
  }

  void _navegateTo(Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
}
