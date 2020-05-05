import 'package:cardapio/login_page.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';

import 'caduser_page.dart';


class Bemvindo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 160,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Seja bem vindo ao \nCardápio Online',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 37, color: Color(0xff777777)),
            ),
            Container(
              height: 100,
            ),
            BotaoWidget(
              nome: 'Acessar',
              clicar: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                print('Clicando em acessar');
              },
            ),
            Container(
              height: 50,
            ),
            BotaoWidget(
              nome: 'Cadastrar',
              clicar: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CadUserPage()));
                print('Clicando em cadastrar');
              },
            ),
          ],
        ),
      ),
    );
  }
}


