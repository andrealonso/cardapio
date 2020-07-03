import 'package:flutter/material.dart';

class BotaoWidget extends StatelessWidget {
  final String nome;
  final Function clicar;
  final Color cor;
  final double largura;

  const BotaoWidget(
      {Key key, this.nome, this.clicar, this.cor = Colors.blue, this.largura})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: largura,
        margin: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Text(
          nome,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 0.5, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: cor,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
      onTap: clicar,
    );
  }
}
