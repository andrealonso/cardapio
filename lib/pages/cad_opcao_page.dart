import 'package:cardapio/pages/cad_estab_page1.dart';
import 'package:cardapio/pages/caduser_page.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';

class CadOpcaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(height: 80,),
        Icon(Icons.person,size: 200,color: Color(0xff0076EB),),
        Container(height: 20,),
                BotaoWidget(
              nome: 'Cadastrar cliente',
              clicar: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadUserPage()));
              },),
              Container(height: 40,),
        Icon(Icons.restaurant_menu,size: 200,color: Color(0xff0076EB),),
        Container(height: 20,),
                BotaoWidget(
              nome: 'Cadastrar estabeleciemtno',
              clicar: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadEstabStep1()));
              },),
      ],)
      
    );
  }
}