import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
 final String texto;

  const Titulo({Key key, this.texto}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(5),
      margin: EdgeInsetsDirectional.only(bottom: 5,top: 15),
      child: Text(texto, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
    );
  }
}

class Paragrafo extends StatelessWidget {
 final String texto;

  const Paragrafo({Key key, this.texto}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(5),
      child: Text(texto, style: TextStyle(fontSize: 20),),
    );
  }
}