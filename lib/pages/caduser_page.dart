import 'dart:convert';

import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/perfil_user_modal.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/services/estab_firestore_service.dart';
import 'package:cardapio/services/perfil_usuario_service.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadUserPage extends StatefulWidget {
  @override
  _CadUserPageState createState() => _CadUserPageState();
}

class _CadUserPageState extends State<CadUserPage> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  var nome = '';
  var sobrenome = '';
  var usuario = '';
  var senha = '';

  Future salvarUsuario() async {
    var sharedPref = await SharedPreferences.getInstance();

    sharedPref.setString('nome', nome);
    sharedPref.setString('sobrenome', sobrenome);
    sharedPref.setString('usuario', usuario);
    sharedPref.setString('senha', senha);
  }

  _cadastrarUsuario() async {
    try {
      var usuarioCadastrado = await _auth.createUserWithEmailAndPassword(
          email: usuario.trim(), password: senha);
      var _perfilNovo = PerfilUsuarioModel(
          nome: nome,
          sobrenome: sobrenome,
          uid: usuarioCadastrado.user.uid,
          img:
              'https://cdn.lucianapepino.com.br/wp-content/uploads/Ryan-Gosling.jpg',
          tipo: 'clienteUser',
          usuario: usuario);

      var _perfilCadastrado =
          await PerfilUsuarioService().criarPerfil(_perfilNovo);

      GetIt.I<UserController>().setUsuario(_perfilNovo);

      print(_perfilCadastrado);
    } catch (e) {
      print(e);
    }

    //await _auth.signInWithEmailAndPassword(email: usuario, password: senha);
    // var _perfil = PerfilUsuarioModel(
    //     nome: nome, sobrenome: sobrenome, uid: _userAtual.uid);
    // await PerfilUsuarioService().criarPerfil(_perfil);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 30,
          right: 30,
        ),
        child: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 100,
                    ),
                    Icon(Icons.photo_camera),
                  ],
                ),
              ),
              Text(
                'Cadastro de usuário',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xff777777),
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo é obrigatório';
                  }
                },
                onSaved: (value) {
                  setState(() {
                    nome = value;
                  });
                },
              ),
              Container(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: 'Sobrenome',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo é obrigatório';
                  }
                },
                onSaved: (value) {
                  setState(() {
                    sobrenome = value;
                  });
                },
              ),
              Container(
                height: 40,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: 'Usuário (Seu email)',
                ),
                validator: (value) {
                  bool emailValid =
                      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(value);
                  if (value.isEmpty) {
                    return 'Preencha o email!';
                  } else {
                    // if (!emailValid){
                    //   return 'O endereço do email não é válido';
                    // }
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    usuario = value;
                  });
                },
              ),
              Container(
                height: 40,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: 'Senha',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo é obrigatório';
                  } else {
                    if (value.length < 6) {
                      return 'A senha precisa ter no mínimo 6 dígitos';
                    }
                  }
                },
                onSaved: (value) {
                  setState(() {
                    senha = value;
                  });
                },
              ),
              Container(
                height: 40,
              ),
              BotaoWidget(
                nome: 'Cadastrar',
                clicar: () {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();
                    salvarUsuario();
                    _cadastrarUsuario();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
