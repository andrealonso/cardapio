import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
 final String texto;

  const Titulo({Key key, this.texto}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(texto, style: TextStyle(fontSize: 16),),
    );
  }
}

class Paragrafo extends StatelessWidget {
 final String texto;

  const Paragrafo({Key key, this.texto}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(texto, style: TextStyle(fontSize: 12),),
    );
  }
}