import 'dart:convert';

import 'package:cardapio/home_page.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadUserPage extends StatefulWidget {
  @override
  _CadUserPageState createState() => _CadUserPageState();
}

class _CadUserPageState extends State<CadUserPage> {
  final formkey = GlobalKey<FormState>();
  var nome = '';
  var sobrenome = '';
  var usuario = '';
  var senha = '';

  Future salvarUsuario() async {
    var sharedPref = await SharedPreferences.getInstance();
    // var user = {
    //   'usuario': usuario,
    //   'senha': senha
    // };
    // sharedPref.setString('user', jsonEncode(user));
    sharedPref.setString('nome', nome);
    sharedPref.setString('sobrenome', sobrenome);
    sharedPref.setString('usuario', usuario);
    sharedPref.setString('senha', senha);

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
                height: 60,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Nome',
                ),
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
                  border: InputBorder.none,
                  labelText: 'Sobrenome',
                ),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Usuário (Nº do Celular)',
                ),
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
                  border: InputBorder.none,
                  labelText: 'Senha',
                ),
                onSaved: (value) {
                  setState(() {
                    senha = value;
                  });
                },
              ),
              Container(
                height: 60,
              ),
              BotaoWidget(
                nome: 'Cadastrar',
                clicar: () {
                  formkey.currentState.save();
                  salvarUsuario();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  print(usuario);
                  print(senha);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
