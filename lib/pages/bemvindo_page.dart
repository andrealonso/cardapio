import 'package:cardapio/pages/login_page.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';

import 'cad_user_page.dart';

class Bemvindo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(

            image: AssetImage('assets/images/tela_bemvindo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(
          top: 160,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Seja bem vindo ao \nCardápio Online',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              height: 100,
            ),
            BotaoWidget(
              nome: 'Acessar',
              clicar: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                print('Clicando em acessar');
              },
            ),
            Container(
              height: 50,
            ),
            BotaoWidget(
              nome: 'Cadastre-se',
              clicar: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CadUserPage()));
                print('Clicando em cadastrar');
              },
            ),
          ],
        ),
      ),
    );
  }
}
