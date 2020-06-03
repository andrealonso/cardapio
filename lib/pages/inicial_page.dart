import 'package:cardapio/pages/bemvindo_page.dart';
import 'package:cardapio/pages/cad_opcao_page.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/pages/login_page.dart';
import 'package:cardapio/services/perfil_usuario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  final _auth = FirebaseAuth.instance;
  final _service = PerfilUsuarioService();

  @override
  void initState() {
    super.initState();
    _navegar();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _navegar() async {
    final userAtual = _auth.currentUser();

    if (userAtual != null) {
      try {
        await _service.getPerfil();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Bemvindo()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
